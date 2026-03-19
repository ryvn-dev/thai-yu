// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Thai Yu';

  @override
  String get pasteThaiText => 'Paste Thai text';

  @override
  String get analyze => 'Analyze';

  @override
  String get learningMode => 'Learning Mode';

  @override
  String get settings => 'Settings';

  @override
  String get apiKeySettings => 'API Settings';

  @override
  String get apiKeyHint => 'Enter your OpenAI API key';

  @override
  String get validate => 'Validate';

  @override
  String get apiKeyValid => 'API key is valid';

  @override
  String get apiKeyInvalid => 'API key is invalid';

  @override
  String get apiKeyNotSet => 'API key not set';

  @override
  String get ttsNote => 'TTS synthesized audio — tones are approximate';

  @override
  String get play => 'Play';

  @override
  String get onset => 'Onset';

  @override
  String get vowel => 'Vowel';

  @override
  String get coda => 'Coda';

  @override
  String get toneMid => 'Mid';

  @override
  String get toneLow => 'Low';

  @override
  String get toneFall => 'Falling';

  @override
  String get toneHigh => 'High';

  @override
  String get toneRise => 'Rising';

  @override
  String get emptyStateTitle => 'Welcome';

  @override
  String get emptyStateHint =>
      'Paste Thai text above to see each word\'s onset, vowel, and tone broken down for you.';

  @override
  String get networkError => 'Unable to connect. Please try again later.';

  @override
  String get nonThaiInput => 'Please enter Thai text';

  @override
  String get silentCoda => 'silent';
}
