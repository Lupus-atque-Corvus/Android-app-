// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String greetingMorning(String name) {
    return 'Good morning, $name!';
  }

  @override
  String greetingDay(String name) {
    return 'Good afternoon, $name!';
  }

  @override
  String greetingEvening(String name) {
    return 'Good evening, $name!';
  }

  @override
  String greetingNight(String name) {
    return 'Good night, $name!';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal steps';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal kcal';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal g protein';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal ml';
  }

  @override
  String get homeBudgetAvailable => 'Available balance';

  @override
  String get homeNoAppointments => 'No appointments today';

  @override
  String get homeNoGoal => 'No active goal';

  @override
  String get homeTodayLabel => 'Today';

  @override
  String homeHabitsStreak(int days) {
    return '$days day streak';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'and $count more';
  }

  @override
  String get homeHealthSleep => 'Sleep';

  @override
  String get homeHealthHeartRate => 'Heart rate';

  @override
  String get homeHealthMood => 'Mood';

  @override
  String get homeWaterAdd200 => '+200 ml';

  @override
  String get homeWaterAdd300 => '+300 ml';

  @override
  String get homeWaterAdd500 => '+500 ml';

  @override
  String get navHome => 'Home';

  @override
  String get navTraining => 'Training';

  @override
  String get navHealth => 'Health';

  @override
  String get navNutrition => 'Nutrition';

  @override
  String get navMore => 'More';

  @override
  String get navPlanning => 'Planning';

  @override
  String get navMedication => 'Medication';

  @override
  String get navSupplements => 'Supplements';

  @override
  String get navAbstinence => 'Abstinence';

  @override
  String get navBudget => 'Budget';

  @override
  String get navPeriod => 'Cycle';

  @override
  String get navSettings => 'Settings';

  @override
  String get trainingStart => 'Start workout';

  @override
  String get trainingHistory => 'Training history';

  @override
  String get trainingLastWorkout => 'Last workout';

  @override
  String get trainingActiveplan => 'Active plan';

  @override
  String get trainingExerciseLibrary => 'Exercise library';

  @override
  String get trainingExerciseProgress => 'Exercise progress';

  @override
  String get trainingVolume => 'Volume';

  @override
  String get trainingDuration => 'Duration';

  @override
  String trainingSetCount(int current, int total) {
    return 'Set $current of $total';
  }

  @override
  String get trainingRestTimer => 'Rest';

  @override
  String get trainingWorkoutSummary => 'Workout complete';

  @override
  String get trainingAddExercise => 'Add exercise';

  @override
  String get trainingCustomExercise => 'Custom exercise';

  @override
  String get healthTitle => 'Health';

  @override
  String get healthOverview => 'Overview';

  @override
  String get healthSleep => 'Sleep';

  @override
  String get healthWeight => 'Weight';

  @override
  String get healthBodyMeasurements => 'Body measurements';

  @override
  String get healthSteps7Days => '7-day trend';

  @override
  String get healthSleepManual => 'Enter manually';

  @override
  String get healthSleepQuality => 'Sleep quality';

  @override
  String get healthWeightGoal => 'Target weight';

  @override
  String get healthHeartRate => 'Resting heart rate';

  @override
  String get healthConnectPermission => 'Health Connect access';

  @override
  String get healthKitPermission => 'Apple Health access';

  @override
  String get healthNoData => 'No data available';

  @override
  String get nutritionTitle => 'Nutrition';

  @override
  String get nutritionCalories => 'Calories';

  @override
  String get nutritionProtein => 'Protein';

  @override
  String get nutritionCarbs => 'Carbs';

  @override
  String get nutritionFat => 'Fat';

  @override
  String get nutritionWater => 'Water';

  @override
  String get nutritionAddMeal => 'Add meal';

  @override
  String get nutritionSaveTemplate => 'Save as template';

  @override
  String get nutritionShoppingList => 'Shopping list';

  @override
  String get supplementTitle => 'Supplements';

  @override
  String get supplementAdd => 'Add supplement';

  @override
  String get supplementTaken => 'Taken';

  @override
  String get supplementPending => 'Pending';

  @override
  String get supplementHistory => 'History';

  @override
  String get medicationTitle => 'Medication';

  @override
  String get medicationAdd => 'Add medication';

  @override
  String get medicationTaken => 'Taken';

  @override
  String get medicationDose => 'Dose';

  @override
  String get medicationCompliance => 'Compliance';

  @override
  String get abstinenceTitle => 'Abstinence';

  @override
  String get abstinenceAdd => 'Add tracker';

  @override
  String abstinenceDays(int days) {
    return '$days days';
  }

  @override
  String get abstinenceRelapse => 'Relapse';

  @override
  String get abstinenceRelapseConfirm => 'Confirm relapse';

  @override
  String get abstinenceRelapseNote => 'Note (optional)';

  @override
  String get abstinenceLongestStreak => 'Longest streak';

  @override
  String get abstinenceLastRelapse => 'Last relapse';

  @override
  String get budgetTitle => 'Budget';

  @override
  String get budgetAvailable => 'Available balance';

  @override
  String get budgetIncome => 'Income';

  @override
  String get budgetExpenses => 'Expenses';

  @override
  String get budgetCategoryExpenses => 'Expenses by category';

  @override
  String get budgetVsLimit => 'Budget vs. expenses';

  @override
  String budgetOverrun(String category) {
    return '$category exceeded!';
  }

  @override
  String get budgetAddTransaction => 'Add transaction';

  @override
  String get budgetSavings => 'Savings goals';

  @override
  String get budgetDebts => 'Debts';

  @override
  String get periodTitle => 'Cycle';

  @override
  String periodDaysUntil(int days) {
    return 'Period in $days days';
  }

  @override
  String get periodFertile => 'Fertile';

  @override
  String get periodNotFertile => 'Not fertile';

  @override
  String get periodOvulation => 'Ovulation';

  @override
  String get periodEnterPeriod => 'Enter period';

  @override
  String get periodEnterSymptoms => 'Enter symptoms';

  @override
  String get periodPregnancyChance => 'Pregnancy probability';

  @override
  String get periodCalendar => 'Calendar';

  @override
  String get periodMyCycles => 'My cycles';

  @override
  String get periodCycleTrends => 'Cycle trends';

  @override
  String get planningTitle => 'Planning';

  @override
  String get planningCalendar => 'Calendar';

  @override
  String get planningTodos => 'Tasks';

  @override
  String get planningGoals => 'Goals';

  @override
  String get planningHabits => 'Habits';

  @override
  String get planningAddAppointment => 'Add appointment';

  @override
  String get planningAddTodo => 'Add task';

  @override
  String get planningAddGoal => 'Add goal';

  @override
  String get planningAddHabit => 'Add habit';

  @override
  String get planningShowAll => 'Show all';

  @override
  String get planningDueDate => 'Due';

  @override
  String get planningPriorityHigh => 'High';

  @override
  String get planningPriorityMedium => 'Medium';

  @override
  String get planningPriorityLow => 'Low';

  @override
  String planningStreakDays(int days) {
    return '$days days';
  }

  @override
  String planningLongestStreak(int days) {
    return 'Longest streak: $days days';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'App theme';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsUnits => 'Units';

  @override
  String get settingsWeightUnit => 'Weight';

  @override
  String get settingsLengthUnit => 'Length';

  @override
  String get settingsTempUnit => 'Temperature';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsPrivacy => 'Privacy & Security';

  @override
  String get settingsPinBiometric => 'PIN / Biometrics';

  @override
  String get settingsExportData => 'Export data';

  @override
  String get settingsBackup => 'Create backup';

  @override
  String get settingsRestore => 'Restore backup';

  @override
  String get settingsWeather => 'Weather';

  @override
  String get settingsNavigation => 'Customize navigation';

  @override
  String get settingsAccount => 'Account & App';

  @override
  String get settingsPeriodTracking => 'Period tracking';

  @override
  String get settingsResetOnboarding => 'Repeat onboarding';

  @override
  String get settingsDeleteAllData => 'Delete all data';

  @override
  String get settingsDeleteConfirmTitle => 'Really delete all data?';

  @override
  String get settingsDeleteConfirmHint => 'Type DELETE to confirm';

  @override
  String get settingsWidgets => 'Widgets';

  @override
  String get settingsSupport => 'Support & Feedback';

  @override
  String get settingsVersion => 'App version';

  @override
  String get supportBugReport => 'Report a bug';

  @override
  String get supportEmailCopied => 'Email address copied: support@traum-app.de';

  @override
  String get supportBugReportHint =>
      'Your email app will open with a pre-filled draft.';

  @override
  String get onboardingWelcomeTitle => 'Welcome to TRAUM';

  @override
  String get onboardingWelcomeSubtitle =>
      'Your personal system. Everything in one place. 100% on your device.';

  @override
  String get onboardingProfileTitle => 'Your profile';

  @override
  String get onboardingProfilePrivacyNote =>
      'The following information helps TRAUM personalise the app for you. All data stays locally on your device.';

  @override
  String get onboardingNameLabel => 'What should we call you?';

  @override
  String get onboardingNameHint => 'Your name';

  @override
  String get onboardingBirthday => 'Birthday (optional)';

  @override
  String get onboardingBiologicalSex => 'Biological sex';

  @override
  String get onboardingSexMale => 'Male';

  @override
  String get onboardingSexFemale => 'Female';

  @override
  String get onboardingSexNone => 'Prefer not to say';

  @override
  String get onboardingPeriodActivated =>
      'Period tracking will be activated for you.';

  @override
  String get onboardingUnits => 'Units';

  @override
  String get onboardingFitnessTitle => 'Fitness & Health';

  @override
  String get onboardingStepsGoal => 'Daily steps goal';

  @override
  String get onboardingCurrentWeight => 'Current weight';

  @override
  String get onboardingTargetWeight => 'Target weight';

  @override
  String get onboardingHeight => 'Height';

  @override
  String get onboardingNutritionTitle => 'Nutrition';

  @override
  String get onboardingCalorieGoal => 'Daily calorie goal';

  @override
  String get onboardingProteinGoal => 'Daily protein goal (g)';

  @override
  String get onboardingWaterGoal => 'Daily water goal (ml)';

  @override
  String get onboardingNutritionHint =>
      'You can adjust these values in settings at any time.';

  @override
  String get onboardingPeriodTitle => 'Your cycle';

  @override
  String get onboardingPeriodSubtitle =>
      'TRAUM calculates your cycle, fertile days, and gives you daily relevant information — no cloud, no data sharing.';

  @override
  String get onboardingLastPeriodStart => 'First day of last period';

  @override
  String get onboardingCycleLength => 'Average cycle length';

  @override
  String get onboardingPeriodLength => 'Average period length';

  @override
  String get onboardingPeriodSetup => 'Set up';

  @override
  String get onboardingPeriodLater => 'Set up later';

  @override
  String get onboardingNavTitle => 'Your navigation';

  @override
  String get onboardingNavSubtitle =>
      'Choose which modules should appear in your navigation bar.';

  @override
  String get onboardingHealthTitle => 'Health data';

  @override
  String get onboardingHealthAndroid =>
      'TRAUM can automatically read steps, sleep and heart rate from Health Connect.';

  @override
  String get onboardingHealthIOS =>
      'TRAUM can automatically read steps, sleep and heart rate from Apple Health.';

  @override
  String get onboardingHealthAllow => 'Allow access';

  @override
  String get onboardingHealthSkip => 'Later';

  @override
  String get onboardingNotifTitle => 'Notifications';

  @override
  String get onboardingNotifSubtitle =>
      'Reminders for medications, water and tasks.';

  @override
  String get onboardingNotifAllow => 'Enable notifications';

  @override
  String get onboardingNotifSkip => 'No thanks';

  @override
  String get onboardingDoneTitle => 'All set.';

  @override
  String get onboardingDoneSubtitle =>
      'Your system is waiting. You can adjust all settings at any time.';

  @override
  String get onboardingDoneHint => 'Your data never leaves this device.';

  @override
  String get onboardingNext => 'Continue';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingFinish => 'Let\'s go';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonClose => 'Close';

  @override
  String get commonBack => 'Back';

  @override
  String get commonShowAll => 'Show all';

  @override
  String get commonNoData => 'No data';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonError => 'Error occurred';

  @override
  String get commonSuccess => 'Saved successfully';

  @override
  String commonDays(int count) {
    return '$count days';
  }

  @override
  String commonHours(int count) {
    return '$count hours';
  }

  @override
  String commonMinutes(int count) {
    return '$count minutes';
  }

  @override
  String get notifMedication => 'Medication';

  @override
  String get notifSupplement => 'Supplements';

  @override
  String get notifWorkout => 'Training';

  @override
  String get notifWater => 'Water';

  @override
  String get notifTodo => 'Tasks';

  @override
  String get notifHabit => 'Habits';

  @override
  String get notifCalendar => 'Calendar';

  @override
  String get notifHealth => 'Health';

  @override
  String get notifBudget => 'Budget';

  @override
  String get notifPeriod => 'Cycle';

  @override
  String get exercise_bench_press => 'Bench Press (Barbell)';

  @override
  String get exercise_push_up => 'Push-Up';

  @override
  String get exercise_pull_up => 'Pull-Up';

  @override
  String get exercise_squat => 'Squat';

  @override
  String get exercise_deadlift => 'Deadlift';

  @override
  String get exercise_shoulder_press => 'Shoulder Press';

  @override
  String get exercise_bicep_curl => 'Bicep Curl';

  @override
  String get exercise_tricep_dip => 'Tricep Dip';

  @override
  String get exercise_plank => 'Plank';

  @override
  String get exercise_running => 'Running';

  @override
  String get exercise_incline_press => 'Incline Press';

  @override
  String get exercise_chest_fly => 'Chest Fly';

  @override
  String get exercise_cable_crossover => 'Cable Crossover';

  @override
  String get exercise_dip => 'Dip';

  @override
  String get exercise_lat_pulldown => 'Lat Pulldown';

  @override
  String get exercise_bent_row => 'Bent-Over Row';

  @override
  String get exercise_seated_row => 'Seated Row';

  @override
  String get exercise_pullover => 'Pullover';

  @override
  String get exercise_face_pull => 'Face Pull';

  @override
  String get exercise_lateral_raise => 'Lateral Raise';

  @override
  String get exercise_front_raise => 'Front Raise';

  @override
  String get exercise_rear_delt_fly => 'Rear Delt Fly';

  @override
  String get exercise_hammer_curl => 'Hammer Curl';

  @override
  String get exercise_concentration_curl => 'Concentration Curl';

  @override
  String get exercise_skull_crusher => 'Skull Crusher';

  @override
  String get exercise_overhead_tricep => 'Overhead Tricep Extension';

  @override
  String get exercise_leg_press => 'Leg Press';

  @override
  String get exercise_leg_curl => 'Leg Curl';

  @override
  String get exercise_leg_extension => 'Leg Extension';

  @override
  String get exercise_calf_raise => 'Calf Raise';

  @override
  String get exercise_lunge => 'Lunge';

  @override
  String get exercise_glute_bridge => 'Glute Bridge';

  @override
  String get exercise_crunch => 'Crunch';

  @override
  String get exercise_russian_twist => 'Russian Twist';

  @override
  String get exercise_leg_raise => 'Leg Raise';

  @override
  String get exercise_mountain_climber => 'Mountain Climber';

  @override
  String get exercise_bicycle_crunch => 'Bicycle Crunch';

  @override
  String get exercise_cycling => 'Cycling';

  @override
  String get exercise_rowing => 'Rowing';

  @override
  String get exercise_jump_rope => 'Jump Rope';

  @override
  String get exercise_burpee => 'Burpee';

  @override
  String get exercise_jumping_jack => 'Jumping Jack';

  @override
  String get exercise_clean => 'Clean';

  @override
  String get exercise_snatch => 'Snatch';

  @override
  String get exercise_thruster => 'Thruster';

  @override
  String get exercise_box_jump => 'Box Jump';

  @override
  String get exercise_battle_rope => 'Battle Rope';

  @override
  String get supplement_vitamin_d3 => 'Vitamin D3';

  @override
  String get supplement_vitamin_c => 'Vitamin C';

  @override
  String get supplement_vitamin_b12 => 'Vitamin B12';

  @override
  String get supplement_vitamin_a => 'Vitamin A';

  @override
  String get supplement_vitamin_e => 'Vitamin E';

  @override
  String get supplement_vitamin_k2 => 'Vitamin K2';

  @override
  String get supplement_vitamin_b_complex => 'Vitamin B Complex';

  @override
  String get supplement_magnesium => 'Magnesium';

  @override
  String get supplement_zinc => 'Zinc';

  @override
  String get supplement_iron => 'Iron';

  @override
  String get supplement_calcium => 'Calcium';

  @override
  String get supplement_selenium => 'Selenium';

  @override
  String get supplement_creatine => 'Creatine';

  @override
  String get supplement_l_glutamine => 'L-Glutamine';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-Arginine';

  @override
  String get supplement_whey_protein => 'Whey Protein';

  @override
  String get supplement_casein => 'Casein Protein';

  @override
  String get supplement_vegan_protein => 'Vegan Protein';

  @override
  String get supplement_omega3 => 'Omega-3';

  @override
  String get supplement_fish_oil => 'Fish Oil';

  @override
  String get supplement_ashwagandha => 'Ashwagandha';

  @override
  String get supplement_rhodiola => 'Rhodiola';

  @override
  String get supplement_caffeine => 'Caffeine';

  @override
  String get supplement_beta_alanine => 'Beta-Alanine';

  @override
  String get supplement_citrulline => 'Citrulline';

  @override
  String get supplement_probiotics => 'Probiotics';

  @override
  String get supplement_prebiotics => 'Prebiotics';
}
