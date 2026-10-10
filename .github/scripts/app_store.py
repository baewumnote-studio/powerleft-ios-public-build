"""Protected App Store signing and direct delivery; no public binary artifacts."""
import argparse
import base64
from datetime import datetime, timedelta, timezone
import hashlib
import json
import os
from pathlib import Path
import plistlib
import re
import secrets
import shutil
import subprocess
import sys
import tempfile
import urllib.parse
import urllib.request
import zipfile

ROOT = Path(__file__).resolve().parents[2]
TEAM = '39762JRYD4'
BUNDLE = 'com.baewumnote.powerleft'
CERTIFICATE_SHA256 = 'faa9fe5ba226b207869a5070716bfb41aa9b95f250c374a4ddffbcb996c981fc'
VERSION = '1.0.0'
TEST_APP = 'ca-app-pub-3940256099942544~1458002511'
TEST_UNIT = 'ca-app-pub-3940256099942544/4411468910'
PRODUCTION_APP = 'ca-app-pub-9507165963073699~3930382930'
PRODUCTION_UNIT = 'ca-app-pub-9507165963073699/3592480748'
PRIVATE_BACKUP_REPOSITORY = 'baewumnote-studio/powerleft'

def mask(value):
    # Workflow commands are escaped before passing sensitive content to the runner.
    if value:
        value=str(value).replace('%','%25').replace('\r','%0D').replace('\n','%0A')
        print('::add-mask::'+value,flush=True)

def command(args, *, data=None, env=None, show_log=False):
    result=subprocess.run([str(a) for a in args],input=data,capture_output=True,env=env,cwd=ROOT)
    if show_log:
        print(result.stdout.decode(errors='replace'),end='')
        print(result.stderr.decode(errors='replace'),end='')
    if result.returncode:
        # Secret-bearing commands deliberately do not echo argv, stdout or stderr.
        raise ValueError(Path(str(args[0])).name+' failed with exit '+str(result.returncode))
    return result.stdout

def profile_from_bytes(raw):
    return plistlib.loads(command(['openssl','cms','-verify','-noverify','-inform','DER'],data=raw))

def validate_profile(profile, now=None):
    now=now or datetime.now(timezone.utc)
    ent=profile.get('Entitlements',{})
    expiry=profile.get('ExpirationDate')
    if not isinstance(expiry,datetime) or expiry.replace(tzinfo=timezone.utc)<=now+timedelta(days=1):
        raise ValueError('The App Store profile must remain valid for more than one day.')
    if (profile.get('TeamIdentifier')!=[TEAM]
        or ent.get('com.apple.developer.team-identifier')!=TEAM
        or ent.get('application-identifier')!=TEAM+'.'+BUNDLE):
        raise ValueError('The profile must match the approved explicit PowerLeft bundle and team.')
    if ('ProvisionedDevices' in profile or profile.get('ProvisionsAllDevices')
        or ent.get('get-task-allow') is not False
        or ent.get('beta-reports-active') is not True):
        raise ValueError('An App Store distribution profile is required; Ad Hoc is rejected.')
    if ent.get('com.apple.security.application-groups'):
        raise ValueError('PowerLeft does not have an App Group or sharing extension.')
    certs=profile.get('DeveloperCertificates',[])
    if (len(certs)!=1 or not isinstance(certs[0],bytes)
        or hashlib.sha256(certs[0]).hexdigest()!=CERTIFICATE_SHA256):
        raise ValueError('The profile must contain the verified existing distribution certificate.')
    if (not re.fullmatch(r'[A-Fa-f0-9-]{36}',str(profile.get('UUID','')))
        or not profile.get('Name')):
        raise ValueError('Missing or invalid provisioning profile identity.')

def validate_public_ids(test_ads, app_id, unit_id):
    if test_ads: return TEST_APP,TEST_UNIT
    if (not re.fullmatch(r'ca-app-pub-[0-9]{16}~[0-9]{10}',app_id)
        or not re.fullmatch(r'ca-app-pub-[0-9]{16}/[0-9]{10}',unit_id)
        or app_id.split('~')[0]!=unit_id.split('/')[0]
        or app_id!=PRODUCTION_APP or unit_id!=PRODUCTION_UNIT):
        raise ValueError('The real PowerLeft AdMob app and interstitial identifiers are required.')
    return app_id,unit_id

def runner_folder():
    parent=Path(os.environ['RUNNER_TEMP']).resolve()
    folder=parent/'powerleft-app-store'
    if not folder.resolve().is_relative_to(parent): raise ValueError('Invalid temporary signing folder.')
    return folder

def backup_request(path, *, payload=None, method='GET', upload=False):
    token=os.environ.get('POWERLEFT_PRIVATE_BACKUP_TOKEN','')
    if not token: raise ValueError('A protected, private-repository-only backup credential is required.')
    mask(token)
    host='uploads.github.com' if upload else 'api.github.com'
    body=payload if upload else (json.dumps(payload).encode() if payload is not None else None)
    headers={'Authorization':'Bearer '+token,'Accept':'application/vnd.github+json',
             'X-GitHub-Api-Version':'2022-11-28',
             'Content-Type':'application/octet-stream' if upload else 'application/json'}
    req=urllib.request.Request('https://'+host+'/repos/'+PRIVATE_BACKUP_REPOSITORY+path,
                               data=body,headers=headers,method=method)
    with urllib.request.urlopen(req,timeout=180 if upload else 30) as response:
        return json.load(response)

def verify_private_backup():
    repository=backup_request('')
    if repository.get('full_name')!=PRIVATE_BACKUP_REPOSITORY or repository.get('private') is not True:
        raise ValueError('Signed binaries can only be retained in the original private PowerLeft repository.')

def preflight():
    # Verify real signing material on inexpensive Linux before a macOS job starts.
    names=('POWERLEFT_DISTRIBUTION_P12_BASE64','POWERLEFT_DISTRIBUTION_P12_PASSWORD',
           'POWERLEFT_APPSTORE_PROFILE_BASE64','POWERLEFT_ASC_PRIVATE_KEY_BASE64',
           'POWERLEFT_ASC_KEY_ID','POWERLEFT_ASC_ISSUER_ID','POWERLEFT_PRIVATE_BACKUP_TOKEN')
    if any(not os.environ.get(name) for name in names):
        raise ValueError('Seven protected App Store environment secrets are required before signing.')
    for name in names: mask(os.environ[name])
    key_id=os.environ[names[4]]; issuer=os.environ[names[5]]
    if not re.fullmatch(r'[A-Z0-9]{10}',key_id) or not re.fullmatch(r'[a-fA-F0-9-]{36}',issuer):
        raise ValueError('Invalid App Store Connect API identity.')
    if not re.fullmatch(r'[1-9][0-9]{0,6}',os.environ.get('POWERLEFT_BUILD_NUMBER','')):
        raise ValueError('Invalid build number.')
    validate_public_ids(os.environ.get('POWERLEFT_TEST_ADS')=='true',
        os.environ.get('POWERLEFT_ADMOB_APP_ID',''),os.environ.get('POWERLEFT_ADMOB_INTERSTITIAL_ID',''))
    profile=profile_from_bytes(base64.b64decode(os.environ[names[2]],validate=True))
    validate_profile(profile)
    api_key=base64.b64decode(os.environ[names[3]],validate=True)
    command(['openssl','pkey','-check','-noout'],data=api_key)
    p12=base64.b64decode(os.environ[names[0]],validate=True)
    environment={**os.environ,'POWERLEFT_P12_CHECK_PASSWORD':os.environ[names[1]]}
    def unpack(options):
        args=['openssl','pkcs12','-passin','env:POWERLEFT_P12_CHECK_PASSWORD']
        try: return command(args+options,data=p12,env=environment)
        except ValueError: return command(args+options+['-legacy'],data=p12,env=environment)
    cert_pem=unpack(['-clcerts','-nokeys'])
    cert=command(['openssl','x509','-outform','DER'],data=cert_pem)
    if hashlib.sha256(cert).hexdigest()!=CERTIFICATE_SHA256:
        raise ValueError('The P12 must contain the verified existing distribution certificate.')
    command(['openssl','x509','-checkend','86400','-noout'],data=cert_pem)
    subject=command(['openssl','x509','-noout','-subject','-nameopt','RFC2253'],data=cert_pem).decode()
    if 'OU='+TEAM not in subject: raise ValueError('Wrong distribution team.')
    private_public=command(['openssl','pkey','-pubout','-outform','DER'],data=unpack(['-nocerts','-nodes']))
    certificate_public=command(['openssl','x509','-pubkey','-noout'],data=cert_pem)
    certificate_public=command(['openssl','pkey','-pubin','-outform','DER'],data=certificate_public)
    if private_public!=certificate_public: raise ValueError('P12 key and certificate do not match.')
    verify_private_backup()
    print('PASS: actual CMS signature, App Store entitlements, P12 password/key/certificate, API key and private backup access verified before macOS.')

def retain_private_binaries(archive,ipa,build):
    verify_private_backup()
    run_id=os.environ.get('GITHUB_RUN_ID','')
    if not re.fullmatch(r'[1-9][0-9]+',run_id): raise ValueError('Missing GitHub run identity for private backup.')
    archive_file=runner_folder()/'powerleft-app-store.xcarchive.tar.gz'
    command(['tar','-czf',archive_file,'-C',archive.parent,archive.name])
    tag='powerleft-store-'+VERSION+'-'+build+'-'+run_id
    release=backup_request('/releases',method='POST',payload={'tag_name':tag,
        'target_commitish':'main','name':'PowerLeft '+VERSION+' ('+build+') private archive',
        'body':'Private signed IPA and original xcarchive; no source commits replaced.',
        'draft':True,'prerelease':True})
    for name,path in (('powerleft.ipa',ipa),('powerleft-app-store.xcarchive.tar.gz',archive_file)):
        raw=path.read_bytes()
        asset=backup_request('/releases/'+str(release['id'])+'/assets?name='+urllib.parse.quote(name),
                             method='POST',payload=raw,upload=True)
        if asset.get('state')!='uploaded' or asset.get('size')!=len(raw):
            raise ValueError('Private distribution archive upload was incomplete.')
        expected=hashlib.sha256(raw).hexdigest()
        if asset.get('digest')!='sha256:'+expected:
            raise ValueError('Private distribution archive digest verification failed.')
    print('PASS: IPA and original xcarchive retained in the original private repository with matching SHA-256.')

def prepare():
    if sys.platform!='darwin': raise ValueError('Signing requires the validated macOS runner.')
    names=('POWERLEFT_DISTRIBUTION_P12_BASE64','POWERLEFT_DISTRIBUTION_P12_PASSWORD',
           'POWERLEFT_APPSTORE_PROFILE_BASE64','POWERLEFT_ASC_PRIVATE_KEY_BASE64',
           'POWERLEFT_ASC_KEY_ID','POWERLEFT_ASC_ISSUER_ID','POWERLEFT_PRIVATE_BACKUP_TOKEN')
    if any(not os.environ.get(name) for name in names):
        raise ValueError('Seven protected App Store environment secrets are required before signing.')
    for name in names: mask(os.environ[name])
    verify_private_backup()
    key_id=os.environ[names[4]]; issuer=os.environ[names[5]]
    if not re.fullmatch(r'[A-Z0-9]{10}',key_id) or not re.fullmatch(r'[a-fA-F0-9-]{36}',issuer):
        raise ValueError('Invalid App Store Connect API identity.')
    build=os.environ.get('POWERLEFT_BUILD_NUMBER','')
    if not re.fullmatch(r'[1-9][0-9]{0,6}',build): raise ValueError('Invalid build number.')
    app_id,unit_id=validate_public_ids(os.environ.get('POWERLEFT_TEST_ADS')=='true',
        os.environ.get('POWERLEFT_ADMOB_APP_ID',''),os.environ.get('POWERLEFT_ADMOB_INTERSTITIAL_ID',''))
    folder=runner_folder()
    folder.mkdir(mode=0o700,exist_ok=False)
    def write(name,data):
        path=folder/name; path.parent.mkdir(mode=0o700,parents=True,exist_ok=True)
        path.write_bytes(data); path.chmod(0o600); return path
    p12=write('distribution.p12',base64.b64decode(os.environ[names[0]],validate=True))
    profile_raw=base64.b64decode(os.environ[names[2]],validate=True)
    profile=profile_from_bytes(profile_raw); validate_profile(profile)
    for value in (profile['UUID'],profile['Name']): mask(value)
    api_key=write('api-keys/AuthKey_'+key_id+'.p8',base64.b64decode(os.environ[names[3]],validate=True))
    command(['openssl','pkey','-in',api_key,'-check','-noout'])
    password=os.environ[names[1]]
    environment={**os.environ,'POWERLEFT_P12_CHECK_PASSWORD':password}
    def unpack(options):
        args=['openssl','pkcs12','-in',p12,'-passin','env:POWERLEFT_P12_CHECK_PASSWORD']
        try: return command(args+options,env=environment)
        except ValueError: return command(args+options+['-legacy'],env=environment)
    cert_pem=unpack(['-clcerts','-nokeys'])
    cert=command(['openssl','x509','-outform','DER'],data=cert_pem)
    if hashlib.sha256(cert).hexdigest()!=CERTIFICATE_SHA256:
        raise ValueError('The P12 must contain the already verified distribution certificate.')
    command(['openssl','x509','-checkend','86400','-noout'],data=cert_pem)
    subject=command(['openssl','x509','-noout','-subject','-nameopt','RFC2253'],data=cert_pem).decode().strip()
    if 'OU='+TEAM not in subject: raise ValueError('Wrong distribution team.')
    # Mask the certificate holder before native signing tools can print their name.
    mask(subject)
    cn_match=re.search(r'CN=(.+?)(?:,|$)',subject)
    if not cn_match: raise ValueError('Missing distribution identity.')
    identity=cn_match.group(1); mask(identity)
    person=re.sub(r'^Apple Distribution:\s*','',identity)
    person=re.sub(r'\s*\([A-Z0-9]+\)$','',person); mask(person)
    private_public=command(['openssl','pkey','-pubout','-outform','DER'],data=unpack(['-nocerts','-nodes']))
    certificate_public=command(['openssl','x509','-pubkey','-noout'],data=cert_pem)
    certificate_public=command(['openssl','pkey','-pubin','-outform','DER'],data=certificate_public)
    if private_public!=certificate_public: raise ValueError('P12 key and certificate do not match.')

    keychain=folder/'signing.keychain-db'
    keychain_password=secrets.token_hex(24); mask(keychain_password)
    command(['security','create-keychain','-p',keychain_password,keychain])
    command(['security','set-keychain-settings','-lut','21600',keychain])
    command(['security','unlock-keychain','-p',keychain_password,keychain])
    command(['security','import',p12,'-P',password,'-T','/usr/bin/codesign','-t','cert','-f','pkcs12','-k',keychain])
    command(['security','set-key-partition-list','-S','apple-tool:,apple:','-k',keychain_password,keychain])
    previous=command(['security','list-keychains','-d','user']).decode()
    search_list=re.findall(r'"([^"\n]+)"',previous)
    write('previous-keychains.json',json.dumps(search_list).encode())
    command(['security','list-keychains','-d','user','-s',keychain,*search_list])
    profiles=Path.home()/'Library/MobileDevice/Provisioning Profiles'
    profiles.mkdir(parents=True,exist_ok=True)
    installed_profile=profiles/(profile['UUID']+'.mobileprovision')
    if installed_profile.exists(): raise ValueError('Refusing to replace an existing runner profile.')
    installed_profile.write_bytes(profile_raw); installed_profile.chmod(0o600)
    state={'profile_path':str(installed_profile),'profile_uuid':profile['UUID'],
           'api_key_id':key_id,'issuer':issuer,'interstitial':unit_id,'build':build}
    # Persist the installed profile location before subsequent project configuration.
    write('state.json',json.dumps(state).encode())
    pbx=ROOT/'ios/Runner.xcodeproj/project.pbxproj'
    text=pbx.read_text()
    anchor='PRODUCT_BUNDLE_IDENTIFIER = '+BUNDLE+';'
    if text.count(anchor)!=3: raise ValueError('Unexpected PowerLeft iOS target configuration.')
    text=text.replace(anchor,anchor+'\n\t\t\t\tDEVELOPMENT_TEAM = '+TEAM+';'
                      +'\n\t\t\t\tCODE_SIGN_STYLE = Manual;'
                      +'\n\t\t\t\tCODE_SIGN_IDENTITY = "Apple Distribution";'
                      +'\n\t\t\t\tPROVISIONING_PROFILE_SPECIFIER = "'+profile['UUID']+'";')
    text=text.replace('"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";',
                      '"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "Apple Distribution";')
    pbx.write_text(text)
    plist_path=ROOT/'ios/Runner/Info.plist'
    info=plistlib.loads(plist_path.read_bytes()); info['GADApplicationIdentifier']=app_id
    plist_path.write_bytes(plistlib.dumps(info,sort_keys=False))
    export={'method':'app-store-connect','teamID':TEAM,'signingStyle':'manual',
            'signingCertificate':'Apple Distribution','manageAppVersionAndBuildNumber':False,
            'provisioningProfiles':{BUNDLE:profile['UUID']},'stripSwiftSymbols':True,
            'destination':'export'}
    write('export-options.plist',plistlib.dumps(export))
    print('PASS: matching App Store profile, existing certificate/key, and protected API key prepared.')

def verify_app(app, build):
    command(['codesign','--verify','--strict','--deep',app],show_log=True)
    info=plistlib.loads((app/'Info.plist').read_bytes())
    if (info.get('CFBundleIdentifier')!=BUNDLE or info.get('CFBundleShortVersionString')!=VERSION
        or info.get('CFBundleVersion')!=build): raise ValueError('Signed app identity/version mismatch.')
    validate_profile(profile_from_bytes((app/'embedded.mobileprovision').read_bytes()))
    ent=plistlib.loads(command(['codesign','-d','--entitlements',':-',app]))
    if (ent.get('application-identifier')!=TEAM+'.'+BUNDLE
        or ent.get('com.apple.developer.team-identifier')!=TEAM
        or ent.get('get-task-allow') is not False
        or ent.get('com.apple.security.application-groups')):
        raise ValueError('Signed app entitlements do not match PowerLeft App Store distribution.')
    prefix=runner_folder()/'signer-cert-'
    command(['codesign','-d','--extract-certificates='+str(prefix),app])
    cert=Path(str(prefix)+'0').read_bytes()
    if hashlib.sha256(cert).hexdigest()!=CERTIFICATE_SHA256: raise ValueError('Unexpected app signing certificate.')

def deliver():
    folder=runner_folder(); state=json.loads((folder/'state.json').read_text())
    for value in (state['profile_uuid'],state['api_key_id'],state['issuer']): mask(value)
    build=state['build']; unit=state['interstitial']
    command(['flutter','pub','get','--enforce-lockfile'],show_log=True)
    command(['flutter','build','ios','--config-only','--release','--no-codesign',
             '--build-name='+VERSION,'--build-number='+build,'--dart-define=ADMOB_INTERSTITIAL_IOS='+unit],show_log=True)
    command(['pod','install','--project-directory=ios'],show_log=True)
    command(['flutter','build','ipa','--release','--no-pub','--build-name='+VERSION,
             '--build-number='+build,'--export-options-plist='+str(folder/'export-options.plist'),
             '--dart-define=ADMOB_INTERSTITIAL_IOS='+unit],show_log=True)
    archives=list((ROOT/'build/ios/archive').glob('*.xcarchive'))
    ipas=list((ROOT/'build/ios/ipa').glob('*.ipa'))
    if len(archives)!=1 or len(ipas)!=1: raise ValueError('Expected exactly one archive and IPA.')
    apps=list((archives[0]/'Products/Applications').glob('*.app'))
    if len(apps)!=1: raise ValueError('Unexpected archive application count.')
    verify_app(apps[0],build)
    with tempfile.TemporaryDirectory(dir=folder) as temp:
        with zipfile.ZipFile(ipas[0]) as archive:
            for entry in archive.infolist():
                target=(Path(temp)/entry.filename).resolve()
                if not target.is_relative_to(Path(temp).resolve()): raise ValueError('Invalid IPA archive path.')
            archive.extractall(temp)
        apps=list((Path(temp)/'Payload').glob('*.app'))
        if len(apps)!=1: raise ValueError('Unexpected IPA application count.')
        verify_app(apps[0],build)
    retain_private_binaries(archives[0],ipas[0],build)
    environment={**os.environ,'API_PRIVATE_KEYS_DIR':str(folder/'api-keys')}
    args=['xcrun','altool','--type','ios','--file',ipas[0],
          '--apiKey',state['api_key_id'],'--apiIssuer',state['issuer']]
    command(args+['--validate-app'],env=environment,show_log=True)
    command(args+['--upload-app'],env=environment,show_log=True)
    print('PASS: signed archive/IPA verified and uploaded directly to App Store Connect.')
    print('App Store Connect processing and TestFlight availability must be checked separately.')

def cleanup():
    folder=runner_folder()
    if not folder.exists(): return
    state=folder/'state.json'
    if state.exists():
        path=Path(json.loads(state.read_text())['profile_path'])
        expected=Path.home()/'Library/MobileDevice/Provisioning Profiles'
        if path.parent!=expected or path.suffix!='.mobileprovision': raise ValueError('Invalid cleanup profile path.')
        path.unlink(missing_ok=True)
    previous=folder/'previous-keychains.json'
    if previous.exists(): command(['security','list-keychains','-d','user','-s',*json.loads(previous.read_text())])
    keychain=folder/'signing.keychain-db'
    if keychain.exists(): command(['security','delete-keychain',keychain])
    # These paths are fixed children of this job's workspace/temporary directory.
    for path in (ROOT/'build/ios/ipa',ROOT/'build/ios/archive',folder):
        if path.exists(): shutil.rmtree(path)
    print('Temporary signing material and distribution binaries removed; no public artifact published.')

if __name__=='__main__':
    parser=argparse.ArgumentParser(); parser.add_argument('operation',choices=('preflight','prepare','deliver','cleanup'))
    operation=parser.parse_args().operation
    try: {'preflight':preflight,'prepare':prepare,'deliver':deliver,'cleanup':cleanup}[operation]()
    except Exception as error:
        if isinstance(error,ValueError): print('STOP: '+str(error))
        else: print('STOP: signing operation failed; '+type(error).__name__+' (private values withheld).')
        raise SystemExit(1)
