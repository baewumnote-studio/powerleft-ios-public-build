from pathlib import Path
import argparse, json, plistlib, re, subprocess, sys
ROOT=Path(__file__).resolve().parents[1]
parser=argparse.ArgumentParser()
parser.add_argument('--ios-dir',default=str(ROOT/'ios'))
parser.add_argument('--values',default=str(ROOT/'PUBLISHER_VALUES_REQUIRED.json'))
parser.add_argument('--release',action='store_true')
args=parser.parse_args(); ios=Path(args.ios_dir); errors=[]; warnings=[]
release_values=None
if args.release:
    vp=Path(args.values)
    r=subprocess.run([sys.executable,str(ROOT/'tool/validate_publisher_values.py'),'--values',str(vp),'--release'],check=False)
    if r.returncode: errors.append('publisher release values did not validate')
    else: release_values=json.loads(vp.read_text(encoding='utf-8'))
if not ios.exists():
    print('GENERATED IOS RUNNER CHECK BLOCKED'); raise SystemExit(2)
info=ios/'Runner'/'Info.plist'
if not info.exists(): errors.append(f'missing {info}')
else:
    try:
        with info.open('rb') as f: plist=plistlib.load(f)
    except Exception as exc:
        errors.append(f'cannot parse Info.plist: {exc}'); plist={}
    forbidden={'NSLocationWhenInUseUsageDescription','NSLocationAlwaysAndWhenInUseUsageDescription','NSCameraUsageDescription','NSPhotoLibraryUsageDescription','NSPhotoLibraryAddUsageDescription','NSMicrophoneUsageDescription','NSBluetoothAlwaysUsageDescription','NSBluetoothPeripheralUsageDescription','NSContactsUsageDescription','NSCalendarsUsageDescription','NSRemindersUsageDescription','NSMotionUsageDescription','NSHealthShareUsageDescription','NSHealthUpdateUsageDescription','NSHomeKitUsageDescription','NSLocalNetworkUsageDescription','NSSpeechRecognitionUsageDescription','NSFaceIDUsageDescription','NSUserTrackingUsageDescription'}
    for key in sorted(forbidden):
        if key in plist: errors.append(f'unexpected MVP permission key: {key}')
    if 'GADApplicationIdentifier' not in plist: errors.append('Runner missing GADApplicationIdentifier')
    elif release_values is not None and plist.get('GADApplicationIdentifier')!=release_values['adMobIosAppId']:
        errors.append('release AdMob App ID does not match publisher values')
for path in ios.rglob('*.entitlements'):
    source=path.read_text(encoding='utf-8',errors='ignore')
    for token in ['aps-environment','com.apple.developer.icloud','com.apple.developer.healthkit','com.apple.developer.homekit','com.apple.developer.associated-domains','com.apple.developer.networking.networkextension','com.apple.developer.nfc']:
        if token in source: errors.append(f'{path.relative_to(ios)}: unexpected MVP entitlement {token}')
pbx=ios/'Runner.xcodeproj'/'project.pbxproj'
if pbx.exists():
    source=pbx.read_text(encoding='utf-8',errors='ignore')
    if (ios/'Runner'/'PrivacyInfo.xcprivacy').exists() and 'PrivacyInfo.xcprivacy' not in source: errors.append('PrivacyInfo.xcprivacy is not referenced by the Xcode project')
    for target in re.findall(r'IPHONEOS_DEPLOYMENT_TARGET\s*=\s*([0-9.]+);',source):
        try:
            if float(target)<15.0: errors.append(f'deployment target {target} below 15.0')
        except ValueError: warnings.append(f'unparseable deployment target {target!r}')
    if release_values is not None:
        desired=release_values['bundleId']; ids=[x.strip().strip('"') for x in re.findall(r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*([^;]+);',source)]
        if desired not in ids: errors.append(f'release Bundle ID {desired!r} not found in Xcode project')
        for value in ids:
            if (value.endswith('.RunnerTests') or value.endswith('.RunnerUITests')) and not value.startswith(desired+'.'): errors.append(f'test target bundle ID not derived from release bundle: {value}')
pod=ios/'Podfile'
if pod.exists():
    ps=pod.read_text(encoding='utf-8',errors='ignore')
    if "platform :ios, '15.0'" not in ps: errors.append('Podfile platform must be iOS 15.0')
    if 'POWERLEFT_IOS15_PODS' not in ps: errors.append('Podfile missing PowerLeft iOS 15 pod deployment normalization')
    for mode in ['Debug', 'Release']:
        config=ios/'Flutter'/f'{mode}.xcconfig'
        include=f'Pods/Target Support Files/Pods-Runner/Pods-Runner.{mode.lower()}.xcconfig'
        if not config.exists() or not re.search(r'^\s*#include\??\s+"'+re.escape(include)+r'"\s*$', config.read_text(encoding='utf-8'), flags=re.M):
            errors.append(f'{mode}.xcconfig missing CocoaPods settings include; PODS_ROOT would be unset')
if errors:
    print('GENERATED IOS RUNNER CHECK FAILED'); [print('ERROR:',e) for e in errors]; [print('WARN:',w) for w in warnings]; raise SystemExit(1)
print('GENERATED IOS RUNNER CHECK PASSED'); print('Entitlements files:',len(list(ios.rglob('*.entitlements')))); [print('WARN:',w) for w in warnings]
