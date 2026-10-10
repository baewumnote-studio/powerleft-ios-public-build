# PowerLeft AdMob Request Policy

Current package target: `google_mobile_ads 9.1.0`.

## Ad formats
Allowed:
- Interstitial only.

Forbidden in MVP:
- Banner
- Native
- Rewarded
- Rewarded interstitial
- App open

## Maximum ad content rating
PowerLeft explicitly applies:

```dart
RequestConfiguration(
  maxAdContentRating: MaxAdContentRating.g,
)
```

before Google Mobile Ads initialization.

`G` is the plugin's "general audiences, including families" content ceiling.

Reason:
- PowerLeft is a broad utility and its current App Store age-rating draft is low;
- the app should not introduce a content-rating mismatch through advertising;
- conservative ad content is preferred over slightly broader inventory for MVP.

This setting does **not** make PowerLeft a Kids app.

## Age treatment
PowerLeft does not globally force a child-directed or under-age treatment flag.

Those flags have legal/regulatory meaning and must not be guessed from the app's
content rating. If the publisher later deliberately targets children or changes
the audience, legal/privacy review is required before changing these settings.

## Timing
All existing frequency/timing policy remains:
- first session: no interstitial;
- >=4 meaningful calculations/actions;
- >=20 minutes between ads;
- max 2/day;
- max 1/session;
- natural transition after result only;
- never before the result;
- ad/consent failure never blocks navigation.
