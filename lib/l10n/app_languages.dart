/// Autonyms stay recognizable even when the current UI language is unfamiliar.
abstract final class AppLanguages {
  static const nativeNames = {
    'en': 'English',
    'ko': '한국어',
    'ja': '日本語',
    'de': 'Deutsch',
    'fr': 'Français',
    'es': 'Español',
  };

  static bool supports(String code) => nativeNames.containsKey(code);
}
