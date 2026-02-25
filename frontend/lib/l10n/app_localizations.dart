import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'ATHLEX'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginTitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordHint;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginButton;

  /// No description provided for @onboardingLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your level'**
  String get onboardingLevelTitle;

  /// No description provided for @onboardingLevelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get onboardingLevelBeginner;

  /// No description provided for @onboardingLevelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get onboardingLevelIntermediate;

  /// No description provided for @onboardingLevelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get onboardingLevelAdvanced;

  /// No description provided for @onboardingSportTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your primary sport'**
  String get onboardingSportTitle;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get navSports;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navProfile;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Dashboard'**
  String get dashboardTitle;

  /// No description provided for @dashboardReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for GYM today?'**
  String get dashboardReady;

  /// No description provided for @dashboardStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak {count} • Rank {rank}'**
  String dashboardStreak(int count, String rank);

  /// No description provided for @dashboardKcal.
  ///
  /// In en, this message translates to:
  /// **'Kcal'**
  String get dashboardKcal;

  /// No description provided for @dashboardTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get dashboardTime;

  /// No description provided for @dashboardPerformance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get dashboardPerformance;

  /// No description provided for @dashboardIntervalTimer.
  ///
  /// In en, this message translates to:
  /// **'Interval Timer'**
  String get dashboardIntervalTimer;

  /// No description provided for @dashboardAiCoach.
  ///
  /// In en, this message translates to:
  /// **'AI Coach'**
  String get dashboardAiCoach;

  /// No description provided for @dashboardDailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dashboardDailyChallenge;

  /// No description provided for @dashboardViewChallenge.
  ///
  /// In en, this message translates to:
  /// **'View Challenge'**
  String get dashboardViewChallenge;

  /// No description provided for @dashboardRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get dashboardRecommended;

  /// No description provided for @dashboardOpenWorkout.
  ///
  /// In en, this message translates to:
  /// **'Open Workout'**
  String get dashboardOpenWorkout;

  /// No description provided for @sportsLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sportsLibraryTitle;

  /// No description provided for @sportsLibrarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Multi-sport training library'**
  String get sportsLibrarySubtitle;

  /// No description provided for @sportsTapExplore.
  ///
  /// In en, this message translates to:
  /// **'Tap to explore workouts'**
  String get sportsTapExplore;

  /// No description provided for @sportsTagPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get sportsTagPrimary;

  /// No description provided for @sportsTagSport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sportsTagSport;

  /// No description provided for @workoutSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get workoutSessionTitle;

  /// No description provided for @workoutSessionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get workoutSessionSave;

  /// No description provided for @workoutWatchVideo.
  ///
  /// In en, this message translates to:
  /// **'Watch Video'**
  String get workoutWatchVideo;

  /// No description provided for @workoutSession.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get workoutSession;

  /// No description provided for @workoutLogCompleted.
  ///
  /// In en, this message translates to:
  /// **'Log completed'**
  String get workoutLogCompleted;

  /// No description provided for @workoutOpenTimer.
  ///
  /// In en, this message translates to:
  /// **'Open timer'**
  String get workoutOpenTimer;

  /// No description provided for @timerTitle.
  ///
  /// In en, this message translates to:
  /// **'Interval Timer'**
  String get timerTitle;

  /// No description provided for @timerNextUp.
  ///
  /// In en, this message translates to:
  /// **'Next: {activity}'**
  String timerNextUp(String activity);

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get progressTitle;

  /// No description provided for @progressTotalWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Total Workouts'**
  String get progressTotalWorkouts;

  /// No description provided for @progressActiveHours.
  ///
  /// In en, this message translates to:
  /// **'Active Hours'**
  String get progressActiveHours;

  /// No description provided for @progressKcalBurned.
  ///
  /// In en, this message translates to:
  /// **'Kcal Burned'**
  String get progressKcalBurned;

  /// No description provided for @progressActivityThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Activity This Week'**
  String get progressActivityThisWeek;

  /// No description provided for @progressHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get progressHistory;

  /// No description provided for @aiCoachTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Coach'**
  String get aiCoachTitle;

  /// No description provided for @aiCoachHint.
  ///
  /// In en, this message translates to:
  /// **'Ask your coach...'**
  String get aiCoachHint;

  /// No description provided for @aiCoachAcceptStart.
  ///
  /// In en, this message translates to:
  /// **'Accept & Start'**
  String get aiCoachAcceptStart;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language Selection'**
  String get settingsLanguage;

  /// No description provided for @settingsCurrentLang.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsCurrentLang;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get settingsTheme;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settingsLogout;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
