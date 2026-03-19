import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Thai Yu'**
  String get appTitle;

  /// No description provided for @pasteThaiText.
  ///
  /// In en, this message translates to:
  /// **'Paste Thai text'**
  String get pasteThaiText;

  /// No description provided for @analyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// No description provided for @learningMode.
  ///
  /// In en, this message translates to:
  /// **'Learning Mode'**
  String get learningMode;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @apiKeySettings.
  ///
  /// In en, this message translates to:
  /// **'API Settings'**
  String get apiKeySettings;

  /// No description provided for @apiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your OpenAI API key'**
  String get apiKeyHint;

  /// No description provided for @validate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validate;

  /// No description provided for @apiKeyValid.
  ///
  /// In en, this message translates to:
  /// **'API key is valid'**
  String get apiKeyValid;

  /// No description provided for @apiKeyInvalid.
  ///
  /// In en, this message translates to:
  /// **'API key is invalid'**
  String get apiKeyInvalid;

  /// No description provided for @apiKeyNotSet.
  ///
  /// In en, this message translates to:
  /// **'API key not set'**
  String get apiKeyNotSet;

  /// No description provided for @ttsNote.
  ///
  /// In en, this message translates to:
  /// **'TTS synthesized audio — tones are approximate'**
  String get ttsNote;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @onset.
  ///
  /// In en, this message translates to:
  /// **'Onset'**
  String get onset;

  /// No description provided for @vowel.
  ///
  /// In en, this message translates to:
  /// **'Vowel'**
  String get vowel;

  /// No description provided for @coda.
  ///
  /// In en, this message translates to:
  /// **'Coda'**
  String get coda;

  /// No description provided for @toneMid.
  ///
  /// In en, this message translates to:
  /// **'Mid'**
  String get toneMid;

  /// No description provided for @toneLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get toneLow;

  /// No description provided for @toneFall.
  ///
  /// In en, this message translates to:
  /// **'Falling'**
  String get toneFall;

  /// No description provided for @toneHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get toneHigh;

  /// No description provided for @toneRise.
  ///
  /// In en, this message translates to:
  /// **'Rising'**
  String get toneRise;

  /// No description provided for @emptyStateTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get emptyStateTitle;

  /// No description provided for @emptyStateHint.
  ///
  /// In en, this message translates to:
  /// **'Paste Thai text above to see each word\'s onset, vowel, and tone broken down for you.'**
  String get emptyStateHint;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect. Please try again later.'**
  String get networkError;

  /// No description provided for @nonThaiInput.
  ///
  /// In en, this message translates to:
  /// **'Please enter Thai text'**
  String get nonThaiInput;

  /// No description provided for @silentCoda.
  ///
  /// In en, this message translates to:
  /// **'silent'**
  String get silentCoda;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
