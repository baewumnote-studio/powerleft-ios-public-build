# PowerLeft Third-Party Software Notice

Checked against the resolved lockfile and local package licenses on 2026-10-10.
All 118 third-party/SDK package entries have a package license or inherit the
Flutter SDK license. Application artwork and source rights are separate.

PowerLeft includes open-source software. The app's About screen opens Flutter's
generated Open Source Licenses view (`showLicensePage`), which should display the
full license texts bundled with the exact resolved dependencies in the release
build.

## Direct dependencies

| Package | Resolved version | License | Publisher / copyright note |
|---|---|---|---|
| Flutter SDK | 3.47.5 | BSD-style | The Flutter Authors |
| flutter_riverpod | 3.4.3 | MIT | Remi Rousselet / Riverpod contributors |
| drift | 2.35.1 | MIT | Simon Binder / Drift contributors |
| drift_flutter | 0.3.1 | MIT | Simon Binder |
| shared_preferences | 2.5.6 | BSD-3-Clause | The Flutter Authors |
| google_mobile_ads | 9.1.0 | Apache-2.0 | Google |
| uuid | 4.6.0 | MIT | Yulian Kuncheff / contributors |
| intl | 0.20.3 | BSD-3-Clause | Dart project authors |

Development-only packages such as `flutter_lints`, `drift_dev`, and
`build_runner` are not intended to be embedded as runtime app functionality,
but their resolved licenses should still be archived with release engineering
records.

## Release rule

Before every public release:
1. run `flutter pub deps`;
2. open the built app's Open Source Licenses screen;
3. verify the exact resolved package licenses are present;
4. archive `pubspec.lock` and dependency output with the release;
5. if a new package has notice/attribution requirements, satisfy them before
   App Store submission.

This file is a convenience inventory. The license text bundled with the exact
resolved package version remains authoritative.

## Current source references
- https://pub.dev/packages/flutter_riverpod/license
- https://pub.dev/packages/drift
- https://pub.dev/packages/drift_flutter/license
- https://pub.dev/packages/shared_preferences/license
- https://pub.dev/packages/google_mobile_ads/versions/9.1.0
- https://pub.dev/packages/uuid/license
- https://pub.dev/packages/intl

## Bundled typography

Noto Sans KR is bundled at `assets/fonts/NotoSansKR.ttf` under the SIL Open
Font License 1.1. The full notice and license are included in
`assets/fonts/OFL.txt` and registered in the app's Open Source Licenses screen.
Source: https://github.com/google/fonts/tree/main/ofl/notosanskr

Noto Sans JP is bundled at `assets/fonts/NotoSansJP.ttf` as a fallback for
Japanese characters outside the Korean font's character set. Its SIL Open
Font License 1.1 notice is included at `assets/fonts/OFL-JP.txt` and registered
in the app's Open Source Licenses screen.
Source: https://github.com/google/fonts/tree/main/ofl/notosansjp

## Preference-storage use

PowerLeft uses the current `SharedPreferencesWithCache` API only for
non-critical preferences and ad-frequency/onboarding counters. Core saved
batteries, devices and setups remain in Drift/SQLite.
