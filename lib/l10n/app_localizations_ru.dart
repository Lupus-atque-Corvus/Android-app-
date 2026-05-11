// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String greetingMorning(String name) {
    return 'Доброе утро, $name!';
  }

  @override
  String greetingDay(String name) {
    return 'Добрый день, $name!';
  }

  @override
  String greetingEvening(String name) {
    return 'Добрый вечер, $name!';
  }

  @override
  String greetingNight(String name) {
    return 'Спокойной ночи, $name!';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal шагов';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal ккал';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal г белка';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal мл';
  }

  @override
  String get homeBudgetAvailable => 'Доступный баланс';

  @override
  String get homeNoAppointments => 'Нет встреч сегодня';

  @override
  String get homeNoGoal => 'Нет активной цели';

  @override
  String get homeTodayLabel => 'Сегодня';

  @override
  String homeHabitsStreak(int days) {
    return 'Серия $days дней';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'и ещё $count';
  }

  @override
  String get homeHealthSleep => 'Сон';

  @override
  String get homeHealthHeartRate => 'Пульс';

  @override
  String get homeHealthMood => 'Настроение';

  @override
  String get homeWaterAdd200 => '+200 мл';

  @override
  String get homeWaterAdd300 => '+300 мл';

  @override
  String get homeWaterAdd500 => '+500 мл';

  @override
  String get navHome => 'Главная';

  @override
  String get navTraining => 'Тренинг';

  @override
  String get navHealth => 'Здоровье';

  @override
  String get navNutrition => 'Питание';

  @override
  String get navMore => 'Ещё';

  @override
  String get navPlanning => 'Планирование';

  @override
  String get navMedication => 'Лекарства';

  @override
  String get navSupplements => 'Добавки';

  @override
  String get navAbstinence => 'Воздержание';

  @override
  String get navBudget => 'Бюджет';

  @override
  String get navPeriod => 'Цикл';

  @override
  String get navSettings => 'Настройки';

  @override
  String get trainingStart => 'Начать тренировку';

  @override
  String get trainingHistory => 'История тренировок';

  @override
  String get trainingLastWorkout => 'Последняя тренировка';

  @override
  String get trainingActiveplan => 'Активный план';

  @override
  String get trainingExerciseLibrary => 'Библиотека упражнений';

  @override
  String get trainingExerciseProgress => 'Прогресс';

  @override
  String get trainingVolume => 'Объём';

  @override
  String get trainingDuration => 'Длительность';

  @override
  String trainingSetCount(int current, int total) {
    return 'Подход $current из $total';
  }

  @override
  String get trainingRestTimer => 'Отдых';

  @override
  String get trainingWorkoutSummary => 'Тренировка завершена';

  @override
  String get trainingAddExercise => 'Добавить упражнение';

  @override
  String get trainingCustomExercise => 'Своё упражнение';

  @override
  String get healthTitle => 'Здоровье';

  @override
  String get healthOverview => 'Обзор';

  @override
  String get healthSleep => 'Сон';

  @override
  String get healthWeight => 'Вес';

  @override
  String get healthBodyMeasurements => 'Замеры тела';

  @override
  String get healthSteps7Days => 'Тренд 7 дней';

  @override
  String get healthSleepManual => 'Ввести вручную';

  @override
  String get healthSleepQuality => 'Качество сна';

  @override
  String get healthWeightGoal => 'Целевой вес';

  @override
  String get healthHeartRate => 'Пульс в покое';

  @override
  String get healthConnectPermission => 'Доступ Health Connect';

  @override
  String get healthKitPermission => 'Доступ Apple Health';

  @override
  String get healthNoData => 'Нет данных';

  @override
  String get nutritionTitle => 'Питание';

  @override
  String get nutritionCalories => 'Калории';

  @override
  String get nutritionProtein => 'Белки';

  @override
  String get nutritionCarbs => 'Углеводы';

  @override
  String get nutritionFat => 'Жиры';

  @override
  String get nutritionWater => 'Вода';

  @override
  String get nutritionAddMeal => 'Добавить приём пищи';

  @override
  String get nutritionSaveTemplate => 'Сохранить как шаблон';

  @override
  String get nutritionShoppingList => 'Список покупок';

  @override
  String get supplementTitle => 'Добавки';

  @override
  String get supplementAdd => 'Добавить добавку';

  @override
  String get supplementTaken => 'Принято';

  @override
  String get supplementPending => 'Ожидает';

  @override
  String get supplementHistory => 'История';

  @override
  String get medicationTitle => 'Лекарства';

  @override
  String get medicationAdd => 'Добавить лекарство';

  @override
  String get medicationTaken => 'Принято';

  @override
  String get medicationDose => 'Доза';

  @override
  String get medicationCompliance => 'Соблюдение';

  @override
  String get abstinenceTitle => 'Воздержание';

  @override
  String get abstinenceAdd => 'Добавить трекер';

  @override
  String abstinenceDays(int days) {
    return '$days дней';
  }

  @override
  String get abstinenceRelapse => 'Срыв';

  @override
  String get abstinenceRelapseConfirm => 'Подтвердить срыв';

  @override
  String get abstinenceRelapseNote => 'Заметка (необязательно)';

  @override
  String get abstinenceLongestStreak => 'Лучшая серия';

  @override
  String get abstinenceLastRelapse => 'Последний срыв';

  @override
  String get budgetTitle => 'Бюджет';

  @override
  String get budgetAvailable => 'Доступный баланс';

  @override
  String get budgetIncome => 'Доходы';

  @override
  String get budgetExpenses => 'Расходы';

  @override
  String get budgetCategoryExpenses => 'Расходы по категориям';

  @override
  String get budgetVsLimit => 'Бюджет vs. расходы';

  @override
  String budgetOverrun(String category) {
    return '$category превышен!';
  }

  @override
  String get budgetAddTransaction => 'Добавить транзакцию';

  @override
  String get budgetSavings => 'Цели сбережений';

  @override
  String get budgetDebts => 'Долги';

  @override
  String get periodTitle => 'Цикл';

  @override
  String periodDaysUntil(int days) {
    return 'Менструация через $days дней';
  }

  @override
  String get periodFertile => 'Фертильный';

  @override
  String get periodNotFertile => 'Нефертильный';

  @override
  String get periodOvulation => 'Овуляция';

  @override
  String get periodEnterPeriod => 'Записать менструацию';

  @override
  String get periodEnterSymptoms => 'Записать симптомы';

  @override
  String get periodPregnancyChance => 'Вероятность беременности';

  @override
  String get periodCalendar => 'Календарь';

  @override
  String get periodMyCycles => 'Мои циклы';

  @override
  String get periodCycleTrends => 'Тренды цикла';

  @override
  String get planningTitle => 'Планирование';

  @override
  String get planningCalendar => 'Календарь';

  @override
  String get planningTodos => 'Задачи';

  @override
  String get planningGoals => 'Цели';

  @override
  String get planningHabits => 'Привычки';

  @override
  String get planningAddAppointment => 'Добавить встречу';

  @override
  String get planningAddTodo => 'Добавить задачу';

  @override
  String get planningAddGoal => 'Добавить цель';

  @override
  String get planningAddHabit => 'Добавить привычку';

  @override
  String get planningShowAll => 'Показать всё';

  @override
  String get planningDueDate => 'Срок';

  @override
  String get planningPriorityHigh => 'Высокий';

  @override
  String get planningPriorityMedium => 'Средний';

  @override
  String get planningPriorityLow => 'Низкий';

  @override
  String planningStreakDays(int days) {
    return '$days дней';
  }

  @override
  String planningLongestStreak(int days) {
    return 'Лучшая серия: $days дней';
  }

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAppearance => 'Внешний вид';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeDark => 'Тёмная';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeSystem => 'Системная';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsUnits => 'Единицы';

  @override
  String get settingsWeightUnit => 'Вес';

  @override
  String get settingsLengthUnit => 'Длина';

  @override
  String get settingsTempUnit => 'Температура';

  @override
  String get settingsNotifications => 'Уведомления';

  @override
  String get settingsPrivacy => 'Конфиденциальность';

  @override
  String get settingsPinBiometric => 'PIN / Биометрия';

  @override
  String get settingsExportData => 'Экспорт данных';

  @override
  String get settingsBackup => 'Создать резервную копию';

  @override
  String get settingsRestore => 'Восстановить';

  @override
  String get settingsWeather => 'Погода';

  @override
  String get settingsNavigation => 'Настройка навигации';

  @override
  String get settingsAccount => 'Аккаунт и приложение';

  @override
  String get settingsPeriodTracking => 'Отслеживание цикла';

  @override
  String get settingsResetOnboarding => 'Повторить обучение';

  @override
  String get settingsDeleteAllData => 'Удалить все данные';

  @override
  String get settingsDeleteConfirmTitle => 'Удалить все данные?';

  @override
  String get settingsDeleteConfirmHint => 'Напишите DELETE для подтверждения';

  @override
  String get settingsWidgets => 'Виджеты';

  @override
  String get settingsSupport => 'Поддержка';

  @override
  String get settingsVersion => 'Версия';

  @override
  String get supportBugReport => 'Сообщить об ошибке';

  @override
  String get supportEmailCopied => 'Email скопирован: support@traum-app.de';

  @override
  String get supportBugReportHint =>
      'Ваше почтовое приложение откроется с готовым черновиком.';

  @override
  String get onboardingWelcomeTitle => 'Добро пожаловать в TRAUM';

  @override
  String get onboardingWelcomeSubtitle =>
      'Ваша личная система. Всё в одном месте.';

  @override
  String get onboardingProfileTitle => 'Ваш профиль';

  @override
  String get onboardingProfilePrivacyNote =>
      'Следующая информация помогает TRAUM персонализировать приложение. Все данные хранятся на вашем устройстве.';

  @override
  String get onboardingNameLabel => 'Как вас называть?';

  @override
  String get onboardingNameHint => 'Ваше имя';

  @override
  String get onboardingBirthday => 'Дата рождения (необязательно)';

  @override
  String get onboardingBiologicalSex => 'Биологический пол';

  @override
  String get onboardingSexMale => 'Мужской';

  @override
  String get onboardingSexFemale => 'Женский';

  @override
  String get onboardingSexNone => 'Не указывать';

  @override
  String get onboardingPeriodActivated =>
      'Отслеживание цикла будет активировано для вас.';

  @override
  String get onboardingUnits => 'Единицы измерения';

  @override
  String get onboardingFitnessTitle => 'Фитнес и здоровье';

  @override
  String get onboardingStepsGoal => 'Цель по шагам в день';

  @override
  String get onboardingCurrentWeight => 'Текущий вес';

  @override
  String get onboardingTargetWeight => 'Целевой вес';

  @override
  String get onboardingHeight => 'Рост';

  @override
  String get onboardingNutritionTitle => 'Питание';

  @override
  String get onboardingCalorieGoal => 'Дневная цель по калориям';

  @override
  String get onboardingProteinGoal => 'Дневная цель по белку (г)';

  @override
  String get onboardingWaterGoal => 'Дневная цель по воде (мл)';

  @override
  String get onboardingNutritionHint =>
      'Вы можете изменить эти значения в настройках в любое время.';

  @override
  String get onboardingPeriodTitle => 'Ваш цикл';

  @override
  String get onboardingPeriodSubtitle =>
      'TRAUM рассчитывает ваш цикл и фертильные дни — без облака, без передачи данных.';

  @override
  String get onboardingLastPeriodStart => 'Первый день последней менструации';

  @override
  String get onboardingCycleLength => 'Средняя длина цикла';

  @override
  String get onboardingPeriodLength => 'Средняя длина менструации';

  @override
  String get onboardingPeriodSetup => 'Настроить';

  @override
  String get onboardingPeriodLater => 'Настроить позже';

  @override
  String get onboardingNavTitle => 'Ваша навигация';

  @override
  String get onboardingNavSubtitle =>
      'Выберите, какие модули отображаются в панели навигации.';

  @override
  String get onboardingHealthTitle => 'Данные о здоровье';

  @override
  String get onboardingHealthAndroid =>
      'TRAUM может автоматически считывать шаги, сон и пульс из Health Connect.';

  @override
  String get onboardingHealthIOS =>
      'TRAUM может автоматически считывать шаги, сон и пульс из Apple Health.';

  @override
  String get onboardingHealthAllow => 'Разрешить доступ';

  @override
  String get onboardingHealthSkip => 'Позже';

  @override
  String get onboardingNotifTitle => 'Уведомления';

  @override
  String get onboardingNotifSubtitle =>
      'Напоминания о лекарствах, воде и задачах.';

  @override
  String get onboardingNotifAllow => 'Включить уведомления';

  @override
  String get onboardingNotifSkip => 'Нет, спасибо';

  @override
  String get onboardingDoneTitle => 'Всё готово.';

  @override
  String get onboardingDoneSubtitle =>
      'Ваша система ждёт вас. Вы можете изменить все настройки в любое время.';

  @override
  String get onboardingDoneHint =>
      'Ваши данные никогда не покинут это устройство.';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingFinish => 'Начать';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonEdit => 'Изменить';

  @override
  String get commonAdd => 'Добавить';

  @override
  String get commonConfirm => 'Подтвердить';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonBack => 'Назад';

  @override
  String get commonShowAll => 'Показать всё';

  @override
  String get commonNoData => 'Нет данных';

  @override
  String get commonLoading => 'Загрузка…';

  @override
  String get commonError => 'Ошибка';

  @override
  String get commonSuccess => 'Сохранено успешно';

  @override
  String commonDays(int count) {
    return '$count дней';
  }

  @override
  String commonHours(int count) {
    return '$count часов';
  }

  @override
  String commonMinutes(int count) {
    return '$count минут';
  }

  @override
  String get notifMedication => 'Лекарства';

  @override
  String get notifSupplement => 'Добавки';

  @override
  String get notifWorkout => 'Тренировка';

  @override
  String get notifWater => 'Вода';

  @override
  String get notifTodo => 'Задачи';

  @override
  String get notifHabit => 'Привычки';

  @override
  String get notifCalendar => 'Календарь';

  @override
  String get notifHealth => 'Здоровье';

  @override
  String get notifBudget => 'Бюджет';

  @override
  String get notifPeriod => 'Цикл';

  @override
  String get exercise_bench_press => 'Жим лёжа (штанга)';

  @override
  String get exercise_push_up => 'Отжимания';

  @override
  String get exercise_pull_up => 'Подтягивания';

  @override
  String get exercise_squat => 'Приседания';

  @override
  String get exercise_deadlift => 'Становая тяга';

  @override
  String get exercise_shoulder_press => 'Жим плечами';

  @override
  String get exercise_bicep_curl => 'Сгибание бицепса';

  @override
  String get exercise_tricep_dip => 'Отжимания на брусьях';

  @override
  String get exercise_plank => 'Планка';

  @override
  String get exercise_running => 'Бег';

  @override
  String get exercise_incline_press => 'Жим на наклонной';

  @override
  String get exercise_chest_fly => 'Разводка гантелей';

  @override
  String get exercise_cable_crossover => 'Кроссовер на блоке';

  @override
  String get exercise_dip => 'Отжимания на брусьях';

  @override
  String get exercise_lat_pulldown => 'Тяга сверху';

  @override
  String get exercise_bent_row => 'Тяга штанги в наклоне';

  @override
  String get exercise_seated_row => 'Тяга к поясу сидя';

  @override
  String get exercise_pullover => 'Пуловер';

  @override
  String get exercise_face_pull => 'Тяга к лицу';

  @override
  String get exercise_lateral_raise => 'Боковые подъёмы';

  @override
  String get exercise_front_raise => 'Подъёмы перед собой';

  @override
  String get exercise_rear_delt_fly => 'Разводка в наклоне';

  @override
  String get exercise_hammer_curl => 'Молотковые сгибания';

  @override
  String get exercise_concentration_curl => 'Концентрированные сгибания';

  @override
  String get exercise_skull_crusher => 'Французский жим';

  @override
  String get exercise_overhead_tricep => 'Разгибания трицепса';

  @override
  String get exercise_leg_press => 'Жим ногами';

  @override
  String get exercise_leg_curl => 'Сгибание ног';

  @override
  String get exercise_leg_extension => 'Разгибание ног';

  @override
  String get exercise_calf_raise => 'Подъём на носки';

  @override
  String get exercise_lunge => 'Выпады';

  @override
  String get exercise_glute_bridge => 'Ягодичный мостик';

  @override
  String get exercise_crunch => 'Скручивания';

  @override
  String get exercise_russian_twist => 'Русские скручивания';

  @override
  String get exercise_leg_raise => 'Подъём ног';

  @override
  String get exercise_mountain_climber => 'Скалолаз';

  @override
  String get exercise_bicycle_crunch => 'Велосипед';

  @override
  String get exercise_cycling => 'Велоспорт';

  @override
  String get exercise_rowing => 'Гребля';

  @override
  String get exercise_jump_rope => 'Скакалка';

  @override
  String get exercise_burpee => 'Бёрпи';

  @override
  String get exercise_jumping_jack => 'Прыжки с разведением рук';

  @override
  String get exercise_clean => 'Подъём на грудь';

  @override
  String get exercise_snatch => 'Рывок';

  @override
  String get exercise_thruster => 'Трастер';

  @override
  String get exercise_box_jump => 'Прыжок на ящик';

  @override
  String get exercise_battle_rope => 'Боевые канаты';

  @override
  String get supplement_vitamin_d3 => 'Витамин D3';

  @override
  String get supplement_vitamin_c => 'Витамин C';

  @override
  String get supplement_vitamin_b12 => 'Витамин B12';

  @override
  String get supplement_vitamin_a => 'Витамин A';

  @override
  String get supplement_vitamin_e => 'Витамин E';

  @override
  String get supplement_vitamin_k2 => 'Витамин K2';

  @override
  String get supplement_vitamin_b_complex => 'Комплекс витаминов B';

  @override
  String get supplement_magnesium => 'Магний';

  @override
  String get supplement_zinc => 'Цинк';

  @override
  String get supplement_iron => 'Железо';

  @override
  String get supplement_calcium => 'Кальций';

  @override
  String get supplement_selenium => 'Селен';

  @override
  String get supplement_creatine => 'Креатин';

  @override
  String get supplement_l_glutamine => 'L-глютамин';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-аргинин';

  @override
  String get supplement_whey_protein => 'Сывороточный протеин';

  @override
  String get supplement_casein => 'Казеин';

  @override
  String get supplement_vegan_protein => 'Веганский протеин';

  @override
  String get supplement_omega3 => 'Омега-3';

  @override
  String get supplement_fish_oil => 'Рыбий жир';

  @override
  String get supplement_ashwagandha => 'Ашваганда';

  @override
  String get supplement_rhodiola => 'Родиола';

  @override
  String get supplement_caffeine => 'Кофеин';

  @override
  String get supplement_beta_alanine => 'Бета-аланин';

  @override
  String get supplement_citrulline => 'Цитруллин';

  @override
  String get supplement_probiotics => 'Пробиотики';

  @override
  String get supplement_prebiotics => 'Пребиотики';

  @override
  String get weatherClear => 'Ясно';

  @override
  String get weatherMostlyClear => 'Преимущественно ясно';

  @override
  String get weatherPartlyCloudy => 'Переменная облачность';

  @override
  String get weatherOvercast => 'Пасмурно';

  @override
  String get weatherFoggy => 'Туман';

  @override
  String get weatherDrizzle => 'Изморось';

  @override
  String get weatherRain => 'Дождь';

  @override
  String get weatherSnowfall => 'Снегопад';

  @override
  String get weatherSnowGrains => 'Снежная крупа';

  @override
  String get weatherRainShowers => 'Ливневые дожди';

  @override
  String get weatherSnowShowers => 'Снежные ливни';

  @override
  String get weatherThunderstorm => 'Гроза';

  @override
  String get weatherHeavyThunderstorm => 'Сильная гроза';
}
