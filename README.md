# PowerLeft

PowerLeft estimates battery runtime and required portable power-station capacity.
It supports Korean, English, Japanese, German, French, and Spanish. Calculations
and saved batteries/devices/setups work locally. Estimates include reserve energy,
conversion loss, average load, and equipment warnings; they are not measurements
or safety guarantees.

This repository contains selected iOS build inputs and starts with its own Git
history. It does not contain signing keys, provisioning profiles, device identifiers,
internal planning documents, distribution binaries, or the private project's history.
No open-source license is granted for the PowerLeft application or its artwork by
this repository. Third-party notices and the bundled font licenses remain applicable.

## Validated toolchain

- Flutter 3.47.5 / Dart 3.13.4
- Xcode 26.3 on the standard GitHub-hosted `macos-15` runner
- Minimum iOS 15, iPhone, portrait orientation
- Bundle ID `com.baewumnote.powerleft`

The existing application code, translations, calculation engine, fonts, icons, and
tests are preserved. The iOS project uses the already confirmed bundle identifier.
The required CocoaPods Debug/Release configuration includes are present.
Native Google Mobile Ads 13.11.0 and UMP 3.1.0 are pinned to the versions read
from the previously verified iPhone binary instead of resolving newer SDKs.

## Manual iOS verification

Open **Actions → PowerLeft iOS release → Run workflow**, select `unsigned`, and
run on `main`. The Linux job checks the locked dependencies, analyzes the app, and
runs the full test suite plus the existing language/UI/first-run checks. The Mac
job runs `flutter build ios --release --no-codesign` after preparing CocoaPods.

There is no automatic push/PR build, paid runner, binary artifact publication, or
App Store review submission. An unsigned build proves compilation only.

## Protected TestFlight delivery

Before using `testflight`, an administrator must configure the `app-store`
environment with main-branch-only deployment and a human required reviewer, then
install the seven encrypted signing/API/backup secrets referenced in the workflow. The
profile must be **App Store distribution**, matching the existing PowerLeft bundle,
team and distribution certificate. Ad Hoc profiles are rejected. Account signing
material is never stored in Git.

Run `unsigned` successfully first. Then select `testflight`, give the successful
unsigned run ID for the **same source commit**, and choose a new build number.
The signing job checks the real CMS profile signature, certificate/private-key
match and validity, verifies the signed archive and exported IPA, and uploads
directly to App Store Connect. It publishes no signed IPA or archive to GitHub.
Signed binaries are retained only in a draft release of the original **private**
PowerLeft repository, with verified upload sizes and SHA-256 digests. Its backup
credential must be a fine-grained token limited to that private repository's
contents permission. Temporary certificates, profiles, API keys and runner binaries
are removed afterward. No existing private source commit or history is replaced.

`test_ads` defaults to false for production delivery. Enabling it explicitly is
for testing only and uses Google's official test app/interstitial IDs.
Production delivery requires the real PowerLeft AdMob values in protected environment
variables `POWERLEFT_ADMOB_APP_ID` and `POWERLEFT_ADMOB_INTERSTITIAL_ID`.
App Store Connect processing, tester availability and actual iPhone verification
remain separate steps after upload. Final store release also requires confirmed
privacy/support/marketing URLs, publisher information, store metadata, and real
screenshots. A build containing test advertisements must not be selected for release.

## Local verification

```sh
flutter pub get --enforce-lockfile
flutter analyze --no-pub
flutter test --no-pub --dart-define=POWERLEFT_DISABLE_ADS_FOR_TESTING=true
flutter test --no-pub --dart-define=POWERLEFT_DISABLE_ADS_FOR_TESTING=true test/widgets/design_ui_checks.dart test/widgets/language_ui_checks.dart test/widgets/app_host_smoke.dart
python3 tool/check_generated_ios_runner.py
python3 tool/test_ios_post_create_fixture.py
python3 tool/check_calculation_vectors.py
python3 -m unittest discover -s .github/scripts -p 'test_*.py'
```

See `docs/CALCULATION_INVARIANTS.md`, `docs/ADMOB_REQUEST_POLICY.md`, and
`THIRD_PARTY_NOTICES.md` for the preserved calculation and advertising rules and
dependency notices.
