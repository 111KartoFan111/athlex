// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'ATHLEX';

  @override
  String get loginTitle => 'Войти';

  @override
  String get loginEmailHint => 'Электронная почта';

  @override
  String get loginPasswordHint => 'Пароль';

  @override
  String get loginForgotPassword => 'Забыли пароль?';

  @override
  String get loginButton => 'Войти';

  @override
  String get onboardingLevelTitle => 'Выберите ваш уровень';

  @override
  String get onboardingLevelBeginner => 'Новичок';

  @override
  String get onboardingLevelIntermediate => 'Средний';

  @override
  String get onboardingLevelAdvanced => 'Продвинутый';

  @override
  String get onboardingSportTitle => 'Выберите основной спорт';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get navHome => 'Главная';

  @override
  String get navSports => 'Спорт';

  @override
  String get navProgress => 'Прогресс';

  @override
  String get navProfile => 'Настройки';

  @override
  String get dashboardTitle => 'Ежедневная сводка';

  @override
  String get dashboardReady => 'Готовы к тренировке сегодня?';

  @override
  String dashboardStreak(int count, String rank) {
    return 'Серия $count • Ранг $rank';
  }

  @override
  String get dashboardKcal => 'Ккал';

  @override
  String get dashboardTime => 'Время';

  @override
  String get dashboardPerformance => 'Эффективность';

  @override
  String get dashboardIntervalTimer => 'Таймер';

  @override
  String get dashboardAiCoach => 'ИИ Тренер';

  @override
  String get dashboardDailyChallenge => 'Избранное испытание';

  @override
  String get dashboardViewChallenge => 'Смотреть вызов';

  @override
  String get dashboardRecommended => 'Рекомендуем';

  @override
  String get dashboardOpenWorkout => 'Начать';

  @override
  String get sportsLibraryTitle => 'Спорт';

  @override
  String get sportsLibrarySubtitle => 'Мультиспортивная библиотека';

  @override
  String get sportsTapExplore => 'Нажмите для просмотра';

  @override
  String get sportsTagPrimary => 'Основной';

  @override
  String get sportsTagSport => 'Спорт';

  @override
  String get workoutSessionTitle => 'Тренировка';

  @override
  String get workoutSessionSave => 'Сохранить';

  @override
  String get workoutWatchVideo => 'Смотреть видео';

  @override
  String get workoutSession => 'Блоки';

  @override
  String get workoutLogCompleted => 'Завершить';

  @override
  String get workoutOpenTimer => 'Открыть таймер';

  @override
  String get timerTitle => 'Таймер интервалов';

  @override
  String timerNextUp(String activity) {
    return 'След: $activity';
  }

  @override
  String get progressTitle => 'Ваш прогресс';

  @override
  String get progressTotalWorkouts => 'Всего тренировок';

  @override
  String get progressActiveHours => 'Часы активности';

  @override
  String get progressKcalBurned => 'Сожжено Ккал';

  @override
  String get progressActivityThisWeek => 'Активность за неделю';

  @override
  String get progressHistory => 'История';

  @override
  String get aiCoachTitle => 'ИИ Тренер';

  @override
  String get aiCoachHint => 'Спросите тренера...';

  @override
  String get aiCoachAcceptStart => 'Принять и начать';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Выбор языка';

  @override
  String get settingsCurrentLang => 'Русский';

  @override
  String get settingsTheme => 'Тема приложения';

  @override
  String get settingsLogout => 'Выйти';
}
