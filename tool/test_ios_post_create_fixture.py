from pathlib import Path
import json,plistlib,shutil,subprocess,sys,tempfile,textwrap
ROOT=Path(__file__).resolve().parents[1]
def fixture(base):
 ios=base/'ios'; r=ios/'Runner'; x=ios/'Runner.xcodeproj'; r.mkdir(parents=True); x.mkdir(parents=True)
 with (r/'Info.plist').open('wb') as f: plistlib.dump({'CFBundleDisplayName':'PowerLeft','CFBundleIdentifier':'$(PRODUCT_BUNDLE_IDENTIFIER)','UISupportedInterfaceOrientations':['UIInterfaceOrientationPortrait','UIInterfaceOrientationLandscapeLeft'],'UISupportedInterfaceOrientations~ipad':['UIInterfaceOrientationPortrait'],'NSCameraUsageDescription':'remove','NSUserTrackingUsageDescription':'remove'},f,sort_keys=False)
 pbx='''// !$*UTF8*$!\n{ objects = {\n/* Begin PBXBuildFile section */\n00112233445566778899AABB /* A in Sources */ = {isa = PBXBuildFile; fileRef = 111122223333444455556666 /* A */; };\n/* End PBXBuildFile section */\n/* Begin PBXFileReference section */\n111122223333444455556666 /* A */ = {isa = PBXFileReference; path = A.swift; sourceTree = "<group>"; };\n/* End PBXFileReference section */\nABCDEF0123456789ABCDEF01 /* Runner */ = {isa = PBXGroup; children = (111122223333444455556666 /* A */,); path = Runner; sourceTree = "<group>"; };\nCCCCCCCCCCCCCCCCCCCCCCCC /* Resources */ = {isa = PBXResourcesBuildPhase; files = (); };\nDDDDDDDDDDDDDDDDDDDDDDDD /* Project object */ = {isa = PBXProject; knownRegions = (en,Base,); };\nEEEEEEEEEEEEEEEEEEEEEEEE /* Debug */ = {isa = XCBuildConfiguration; buildSettings = { DEVELOPMENT_TEAM = OLDTEAM1234; IPHONEOS_DEPLOYMENT_TARGET = 12.0; PRODUCT_BUNDLE_IDENTIFIER = com.example.powerleft; }; };\nFFFFFFFFFFFFFFFFFFFFFFFF /* Release */ = {isa = XCBuildConfiguration; buildSettings = { DEVELOPMENT_TEAM = OLDTEAM1234; IPHONEOS_DEPLOYMENT_TARGET = 13.0; PRODUCT_BUNDLE_IDENTIFIER = com.example.powerleft; }; };\n1234567890ABCDEF12345678 /* RunnerTests */ = {isa = XCBuildConfiguration; buildSettings = { DEVELOPMENT_TEAM = OLDTEAM1234; IPHONEOS_DEPLOYMENT_TARGET = 13.0; PRODUCT_BUNDLE_IDENTIFIER = com.example.powerleft.RunnerTests; }; };\n}; }\n'''
 (x/'project.pbxproj').write_text(pbx,encoding='utf-8')
 (ios/'Podfile').write_text("platform :ios, '12.0'\npost_install do |installer|\n  installer.pods_project.targets.each do |target|\n    flutter_additional_ios_build_settings(target)\n  end\nend\n",encoding='utf-8')
 (ios/'Flutter').mkdir()
 for mode in ['Debug', 'Release']:
  (ios/'Flutter'/f'{mode}.xcconfig').write_text(f'#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.{mode.lower()}.xcconfig"\n#include "Generated.xcconfig"\n',encoding='utf-8')
 return ios
def run(cmd):
 r=subprocess.run(cmd,capture_output=True,text=True)
 if r.returncode: print(r.stdout); print(r.stderr); raise SystemExit(r.returncode)
 return r
with tempfile.TemporaryDirectory(prefix='powerleft_ios_') as t:
 b=Path(t); d=fixture(b/'debug')
 run([sys.executable,str(ROOT/'tool/apply_ios_post_create.py'),'--ios-dir',str(d)])
 run([sys.executable,str(ROOT/'tool/check_generated_ios_runner.py'),'--ios-dir',str(d)])
 with (d/'Runner/Info.plist').open('rb') as f: info=plistlib.load(f)
 assert info['GADApplicationIdentifier']=='ca-app-pub-3940256099942544~1458002511'; assert 'NSUserTrackingUsageDescription' not in info; assert 'NSCameraUsageDescription' not in info; assert 'ITSAppUsesNonExemptEncryption' not in info
 assert 'PrivacyInfo.xcprivacy in Resources' in (d/'Runner.xcodeproj/project.pbxproj').read_text(encoding='utf-8'); assert 'POWERLEFT_IOS15_PODS' in (d/'Podfile').read_text(encoding='utf-8')
 config=d/'Flutter/Debug.xcconfig'; original=config.read_bytes()
 config.write_text('#include "Generated.xcconfig"\n',encoding='utf-8')
 missing=subprocess.run([sys.executable,str(ROOT/'tool/check_generated_ios_runner.py'),'--ios-dir',str(d)],capture_output=True,text=True)
 assert missing.returncode==1 and 'PODS_ROOT would be unset' in missing.stdout
 config.write_bytes(original)
 vals={'bundleId':'com.example.powerleftqa','appleTeamId':'ABCDE12345','adMobPublisherId':'pub-1234567890123456','adMobIosAppId':'ca-app-pub-1234567890123456~1234567890','adMobInterstitialIosUnitId':'ca-app-pub-1234567890123456/1234567890','developerWebsiteUrl':'https://example.com','privacyPolicyUrl':'https://example.com/privacy-en.html','privacyChoicesUrl':'https://example.com/privacy-choices-en.html','supportUrl':'https://example.com/support-en.html','supportEmail':'support@example.com','appReviewContactName':'QA Tester','appReviewContactEmail':'review@example.com','appReviewContactPhone':'+82 10 1234 5678','dsaTraderStatus':'non-trader','dsaPublicAddress':'<NOT_APPLICABLE>','dsaPublicPhone':'<NOT_APPLICABLE>','dsaPublicEmail':'<NOT_APPLICABLE>'}
 vp=b/'values.json'; vp.write_text(json.dumps(vals),encoding='utf-8'); r=fixture(b/'release')
 # flutter create emits no DEVELOPMENT_TEAM before a publisher selects one.
 project=r/'Runner.xcodeproj/project.pbxproj'
 project.write_text(project.read_text(encoding='utf-8').replace('DEVELOPMENT_TEAM = OLDTEAM1234;', ''),encoding='utf-8')
 run([sys.executable,str(ROOT/'tool/apply_ios_post_create.py'),'--ios-dir',str(r),'--values',str(vp),'--release','--confirm-exempt-encryption'])
 run([sys.executable,str(ROOT/'tool/check_generated_ios_runner.py'),'--ios-dir',str(r),'--values',str(vp),'--release'])
 with (r/'Runner/Info.plist').open('rb') as f: info=plistlib.load(f)
 assert info['GADApplicationIdentifier']==vals['adMobIosAppId']; assert info['ITSAppUsesNonExemptEncryption'] is False
 pb=(r/'Runner.xcodeproj/project.pbxproj').read_text(encoding='utf-8'); assert 'PRODUCT_BUNDLE_IDENTIFIER = com.example.powerleftqa;' in pb; assert 'PRODUCT_BUNDLE_IDENTIFIER = com.example.powerleftqa.RunnerTests;' in pb; assert 'DEVELOPMENT_TEAM = ABCDE12345;' in pb
print('IOS POST-CREATE FIXTURE TEST PASSED')
