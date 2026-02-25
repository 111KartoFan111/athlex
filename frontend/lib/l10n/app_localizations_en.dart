// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ATHLEX';

  @override
  String get loginTitle => 'Log In';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginButton => 'Log In';

  @override
  String get onboardingLevelTitle => 'Select your level';

  @override
  String get onboardingLevelBeginner => 'Beginner';

  @override
  String get onboardingLevelIntermediate => 'Intermediate';

  @override
  String get onboardingLevelAdvanced => 'Advanced';

  @override
  String get onboardingSportTitle => 'Choose your primary sport';

  @override
  String get onboardingNext => 'Next';

  @override
  String get navHome => 'Home';

  @override
  String get navSports => 'Sports';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Settings';

  @override
  String get dashboardTitle => 'Daily Dashboard';

  @override
  String get dashboardReady => 'Ready for GYM today?';

  @override
  String dashboardStreak(int count, String rank) {
    return 'Streak $count • Rank $rank';
  }

  @override
  String get dashboardKcal => 'Kcal';

  @override
  String get dashboardTime => 'Time';

  @override
  String get dashboardPerformance => 'Performance';

  @override
  String get dashboardIntervalTimer => 'Interval Timer';

  @override
  String get dashboardAiCoach => 'AI Coach';

  @override
  String get dashboardDailyChallenge => 'Daily Challenge';

  @override
  String get dashboardViewChallenge => 'View Challenge';

  @override
  String get dashboardRecommended => 'Recommended';

  @override
  String get dashboardOpenWorkout => 'Open Workout';

  @override
  String get sportsLibraryTitle => 'Sports';

  @override
  String get sportsLibrarySubtitle => 'Multi-sport training library';

  @override
  String get sportsTapExplore => 'Tap to explore workouts';

  @override
  String get sportsTagPrimary => 'Primary';

  @override
  String get sportsTagSport => 'Sport';

  @override
  String get workoutSessionTitle => 'Workout';

  @override
  String get workoutSessionSave => 'Save';

  @override
  String get workoutWatchVideo => 'Watch Video';

  @override
  String get workoutSession => 'Session';

  @override
  String get workoutLogCompleted => 'Log completed';

  @override
  String get workoutOpenTimer => 'Open timer';

  @override
  String get timerTitle => 'Interval Timer';

  @override
  String timerNextUp(String activity) {
    return 'Next: $activity';
  }

  @override
  String get progressTitle => 'Your Progress';

  @override
  String get progressTotalWorkouts => 'Total Workouts';

  @override
  String get progressActiveHours => 'Active Hours';

  @override
  String get progressKcalBurned => 'Kcal Burned';

  @override
  String get progressActivityThisWeek => 'Activity This Week';

  @override
  String get progressHistory => 'History';

  @override
  String get aiCoachTitle => 'AI Coach';

  @override
  String get aiCoachHint => 'Ask your coach...';

  @override
  String get aiCoachAcceptStart => 'Accept & Start';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language Selection';

  @override
  String get settingsCurrentLang => 'English';

  @override
  String get settingsTheme => 'App Theme';

  @override
  String get settingsLogout => 'Log Out';
}
