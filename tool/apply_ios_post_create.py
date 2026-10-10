from pathlib import Path
import argparse,json,plistlib,re,shutil,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
parser=argparse.ArgumentParser()
parser.add_argument('--values',default=str(ROOT/'PUBLISHER_VALUES_REQUIRED.json'))
parser.add_argument('--ios-dir',default=str(ROOT/'ios'))
parser.add_argument('--release',action='store_true')
parser.add_argument('--confirm-exempt-encryption',action='store_true')
args=parser.parse_args(); ios=Path(args.ios_dir); values_path=Path(args.values)
if not ios.exists(): print('ERROR: generated iOS directory does not exist:',ios); raise SystemExit(1)
values=json.loads(values_path.read_text(encoding='utf-8'))
if args.release:
 r=subprocess.run([sys.executable,str(ROOT/'tool/validate_publisher_values.py'),'--values',str(values_path),'--release'],check=False)
 if r.returncode: raise SystemExit(r.returncode)
runner=ios/'Runner'; info_path=runner/'Info.plist'; pbx_path=ios/'Runner.xcodeproj'/'project.pbxproj'; podfile=ios/'Podfile'
for x in [runner,info_path,pbx_path]:
 if not x.exists(): print('ERROR: missing',x); raise SystemExit(1)
with info_path.open('rb') as f: info=plistlib.load(f)
info['CFBundleDisplayName']='PowerLeft'
skad_text=(ROOT/'ios_config'/'SKAdNetworkItems_2026-10-02.xml').read_text(encoding='utf-8')
info['SKAdNetworkItems']=plistlib.loads(('<plist version="1.0"><dict>'+skad_text+'</dict></plist>').encode('utf-8'))['SKAdNetworkItems']
info['GADApplicationIdentifier']=values['adMobIosAppId'].strip() if args.release else 'ca-app-pub-3940256099942544~1458002511'
for key in ['NSUserTrackingUsageDescription','NSLocationWhenInUseUsageDescription','NSLocationAlwaysAndWhenInUseUsageDescription','NSCameraUsageDescription','NSPhotoLibraryUsageDescription','NSPhotoLibraryAddUsageDescription','NSMicrophoneUsageDescription','NSBluetoothAlwaysUsageDescription','NSBluetoothPeripheralUsageDescription','NSContactsUsageDescription','NSCalendarsUsageDescription','NSRemindersUsageDescription','NSMotionUsageDescription','NSHealthShareUsageDescription','NSHealthUpdateUsageDescription','NSHomeKitUsageDescription','NSLocalNetworkUsageDescription','NSSpeechRecognitionUsageDescription','NSFaceIDUsageDescription']:
 info.pop(key,None)
if args.confirm_exempt_encryption: info['ITSAppUsesNonExemptEncryption']=False
info['UISupportedInterfaceOrientations']=['UIInterfaceOrientationPortrait']; info.pop('UISupportedInterfaceOrientations~ipad',None)
with info_path.open('wb') as f: plistlib.dump(info,f,sort_keys=False)
privacy_src=ROOT/'ios_config'/'PrivacyInfo.xcprivacy'; privacy_dst=runner/'PrivacyInfo.xcprivacy'; shutil.copy2(privacy_src,privacy_dst)
pbx=pbx_path.read_text(encoding='utf-8')
pbx=re.sub(r'IPHONEOS_DEPLOYMENT_TARGET\s*=\s*[0-9.]+;','IPHONEOS_DEPLOYMENT_TARGET = 15.0;',pbx)
pbx=re.sub(r'TARGETED_DEVICE_FAMILY\s*=\s*[^;]+;','TARGETED_DEVICE_FAMILY = 1;',pbx)
if args.release:
 bundle=values['bundleId'].strip(); team=values['appleTeamId'].strip()
 def repl_bundle(m):
  cur=m.group(1).strip().strip('"'); suffix=''
  for s in ['.RunnerTests','.RunnerUITests','.Tests','.UITests']:
   if cur.endswith(s): suffix=s; break
  return f'PRODUCT_BUNDLE_IDENTIFIER = {bundle}{suffix};'
 pbx=re.sub(r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*([^;]+);',repl_bundle,pbx)
 if 'DEVELOPMENT_TEAM =' in pbx: pbx=re.sub(r'DEVELOPMENT_TEAM\s*=\s*[^;]+;',f'DEVELOPMENT_TEAM = {team};',pbx)
 def add_missing_team(m):
  body=m.group(2)
  if 'PRODUCT_BUNDLE_IDENTIFIER =' in body and 'DEVELOPMENT_TEAM =' not in body:
   body=f'\n\t\t\t\tDEVELOPMENT_TEAM = {team};'+body
  return m.group(1)+body+m.group(3)
 pbx=re.sub(r'(buildSettings\s*=\s*\{)(.*?)(\};)',add_missing_team,pbx,flags=re.S)
m=re.search(r'knownRegions\s*=\s*\((.*?)\);',pbx,flags=re.S)
if m:
 body=m.group(1); existing=set(re.findall(r'^\s*([A-Za-z_-]+)\s*,\s*$',body,flags=re.M)); newbody=body.rstrip()
 for region in ['en','ko','ja','de','fr','es','Base']:
  if region not in existing: newbody+=f'\n\t\t\t\t{region},'
 newbody+='\n\t\t\t'; pbx=pbx[:m.start(1)]+newbody+pbx[m.end(1):]
if 'PrivacyInfo.xcprivacy' not in pbx:
 fr='A15A0B01C02D03E04F05A006'; br='B15B0C01D02E03F04A05B006'
 if '/* End PBXBuildFile section */' not in pbx or '/* End PBXFileReference section */' not in pbx: raise SystemExit('ERROR: PBX sections missing')
 pbx=pbx.replace('/* End PBXBuildFile section */',f'\t\t{br} /* PrivacyInfo.xcprivacy in Resources */ = {{isa = PBXBuildFile; fileRef = {fr} /* PrivacyInfo.xcprivacy */; }};\n/* End PBXBuildFile section */',1)
 pbx=pbx.replace('/* End PBXFileReference section */',f'\t\t{fr} /* PrivacyInfo.xcprivacy */ = {{isa = PBXFileReference; lastKnownFileType = text.xml; path = PrivacyInfo.xcprivacy; sourceTree = "<group>"; }};\n/* End PBXFileReference section */',1)
 rg=re.search(r'([A-Fa-f0-9]{24}\s*/\*\s*Runner\s*\*/\s*=\s*\{[\s\S]*?children\s*=\s*\()(.*?)(\);)',pbx,flags=re.S)
 rp=re.search(r'([A-Fa-f0-9]{24}\s*/\*\s*Resources\s*\*/\s*=\s*\{[\s\S]*?isa\s*=\s*PBXResourcesBuildPhase;[\s\S]*?files\s*=\s*\()(.*?)(\);)',pbx,flags=re.S)
 if not rg or not rp: raise SystemExit('ERROR: Runner group/resources phase missing')
 body=rg.group(2).rstrip()+f'\n\t\t\t\t{fr} /* PrivacyInfo.xcprivacy */,\n\t\t\t'; pbx=pbx[:rg.start(2)]+body+pbx[rg.end(2):]
 rp=re.search(r'([A-Fa-f0-9]{24}\s*/\*\s*Resources\s*\*/\s*=\s*\{[\s\S]*?isa\s*=\s*PBXResourcesBuildPhase;[\s\S]*?files\s*=\s*\()(.*?)(\);)',pbx,flags=re.S)
 body=rp.group(2).rstrip()+f'\n\t\t\t\t{br} /* PrivacyInfo.xcprivacy in Resources */,\n\t\t\t'; pbx=pbx[:rp.start(2)]+body+pbx[rp.end(2):]
pbx_path.write_text(pbx,encoding='utf-8')
if podfile.exists():
 pod=podfile.read_text(encoding='utf-8')
 if re.search(r'(?m)^\s*platform\s*:ios,',pod): pod=re.sub(r'(?m)^\s*platform\s*:ios,\s*[\'\"][0-9.]+[\'\"]',"platform :ios, '15.0'",pod,count=1)
 else: pod="platform :ios, '15.0'\n\n"+pod
 if '# POWERLEFT_IOS15_PODS' not in pod:
  fs='flutter_additional_ios_build_settings(target)'
  if 'post_install do |installer|' in pod and fs in pod:
   ins="\n    # POWERLEFT_IOS15_PODS\n    target.build_configurations.each do |config|\n      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'\n    end\n"; pod=pod.replace(fs,fs+ins,1)
  elif 'post_install do |installer|' not in pod:
   pod+="\n# POWERLEFT_IOS15_PODS\npost_install do |installer|\n  installer.pods_project.targets.each do |target|\n    flutter_additional_ios_build_settings(target)\n    target.build_configurations.each do |config|\n      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'\n    end\n  end\nend\n"
  else: raise SystemExit('ERROR: nonstandard post_install hook')
 podfile.write_text(pod,encoding='utf-8')
print('POWERLEFT IOS POST-CREATE CONFIG APPLIED')
print('Mode:', 'release' if args.release else 'debug/template')
