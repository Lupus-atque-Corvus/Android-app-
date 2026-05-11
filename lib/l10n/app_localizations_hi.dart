// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String greetingMorning(String name) {
    return 'सुप्रभात, $name!';
  }

  @override
  String greetingDay(String name) {
    return 'नमस्ते, $name!';
  }

  @override
  String greetingEvening(String name) {
    return 'शुभ संध्या, $name!';
  }

  @override
  String greetingNight(String name) {
    return 'शुभ रात्रि, $name!';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal कदम';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal कैलोरी';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal ग्राम प्रोटीन';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal मिली';
  }

  @override
  String get homeBudgetAvailable => 'उपलब्ध राशि';

  @override
  String get homeNoAppointments => 'आज कोई अपॉइंटमेंट नहीं';

  @override
  String get homeNoGoal => 'कोई सक्रिय लक्ष्य नहीं';

  @override
  String get homeTodayLabel => 'आज';

  @override
  String homeHabitsStreak(int days) {
    return '$days दिन की स्ट्रीक';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'और $count और';
  }

  @override
  String get homeHealthSleep => 'नींद';

  @override
  String get homeHealthHeartRate => 'हृदय गति';

  @override
  String get homeHealthMood => 'मूड';

  @override
  String get homeWaterAdd200 => '+200 मिली';

  @override
  String get homeWaterAdd300 => '+300 मिली';

  @override
  String get homeWaterAdd500 => '+500 मिली';

  @override
  String get navHome => 'होम';

  @override
  String get navTraining => 'ट्रेनिंग';

  @override
  String get navHealth => 'स्वास्थ्य';

  @override
  String get navNutrition => 'पोषण';

  @override
  String get navMore => 'अधिक';

  @override
  String get navPlanning => 'योजना';

  @override
  String get navMedication => 'दवाई';

  @override
  String get navSupplements => 'सप्लीमेंट';

  @override
  String get navAbstinence => 'संयम';

  @override
  String get navBudget => 'बजट';

  @override
  String get navPeriod => 'चक्र';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get trainingStart => 'वर्कआउट शुरू करें';

  @override
  String get trainingHistory => 'प्रशिक्षण इतिहास';

  @override
  String get trainingLastWorkout => 'अंतिम वर्कआउट';

  @override
  String get trainingActiveplan => 'सक्रिय योजना';

  @override
  String get trainingExerciseLibrary => 'व्यायाम पुस्तकालय';

  @override
  String get trainingExerciseProgress => 'प्रगति';

  @override
  String get trainingVolume => 'वॉल्यूम';

  @override
  String get trainingDuration => 'अवधि';

  @override
  String trainingSetCount(int current, int total) {
    return 'सेट $current / $total';
  }

  @override
  String get trainingRestTimer => 'आराम';

  @override
  String get trainingWorkoutSummary => 'वर्कआउट पूर्ण';

  @override
  String get trainingAddExercise => 'व्यायाम जोड़ें';

  @override
  String get trainingCustomExercise => 'कस्टम व्यायाम';

  @override
  String get healthTitle => 'स्वास्थ्य';

  @override
  String get healthOverview => 'अवलोकन';

  @override
  String get healthSleep => 'नींद';

  @override
  String get healthWeight => 'वजन';

  @override
  String get healthBodyMeasurements => 'शरीर माप';

  @override
  String get healthSteps7Days => '7 दिन का रुझान';

  @override
  String get healthSleepManual => 'मैन्युअल रूप से दर्ज करें';

  @override
  String get healthSleepQuality => 'नींद की गुणवत्ता';

  @override
  String get healthWeightGoal => 'लक्ष्य वजन';

  @override
  String get healthHeartRate => 'आराम की हृदय गति';

  @override
  String get healthConnectPermission => 'Health Connect अनुमति';

  @override
  String get healthKitPermission => 'Apple Health अनुमति';

  @override
  String get healthNoData => 'कोई डेटा उपलब्ध नहीं';

  @override
  String get nutritionTitle => 'पोषण';

  @override
  String get nutritionCalories => 'कैलोरी';

  @override
  String get nutritionProtein => 'प्रोटीन';

  @override
  String get nutritionCarbs => 'कार्बोहाइड्रेट';

  @override
  String get nutritionFat => 'वसा';

  @override
  String get nutritionWater => 'पानी';

  @override
  String get nutritionAddMeal => 'भोजन जोड़ें';

  @override
  String get nutritionSaveTemplate => 'टेम्पलेट के रूप में सहेजें';

  @override
  String get nutritionShoppingList => 'खरीदारी सूची';

  @override
  String get supplementTitle => 'सप्लीमेंट';

  @override
  String get supplementAdd => 'सप्लीमेंट जोड़ें';

  @override
  String get supplementTaken => 'लिया गया';

  @override
  String get supplementPending => 'बाकी';

  @override
  String get supplementHistory => 'इतिहास';

  @override
  String get medicationTitle => 'दवाई';

  @override
  String get medicationAdd => 'दवाई जोड़ें';

  @override
  String get medicationTaken => 'लिया गया';

  @override
  String get medicationDose => 'खुराक';

  @override
  String get medicationCompliance => 'अनुपालन';

  @override
  String get abstinenceTitle => 'संयम';

  @override
  String get abstinenceAdd => 'ट्रैकर जोड़ें';

  @override
  String abstinenceDays(int days) {
    return '$days दिन';
  }

  @override
  String get abstinenceRelapse => 'पुनरावृत्ति';

  @override
  String get abstinenceRelapseConfirm => 'पुनरावृत्ति की पुष्टि करें';

  @override
  String get abstinenceRelapseNote => 'नोट (वैकल्पिक)';

  @override
  String get abstinenceLongestStreak => 'सबसे लंबी स्ट्रीक';

  @override
  String get abstinenceLastRelapse => 'अंतिम पुनरावृत्ति';

  @override
  String get budgetTitle => 'बजट';

  @override
  String get budgetAvailable => 'उपलब्ध राशि';

  @override
  String get budgetIncome => 'आय';

  @override
  String get budgetExpenses => 'खर्च';

  @override
  String get budgetCategoryExpenses => 'श्रेणी के अनुसार खर्च';

  @override
  String get budgetVsLimit => 'बजट बनाम खर्च';

  @override
  String budgetOverrun(String category) {
    return '$category अधिक हो गया!';
  }

  @override
  String get budgetAddTransaction => 'लेनदेन जोड़ें';

  @override
  String get budgetSavings => 'बचत लक्ष्य';

  @override
  String get budgetDebts => 'कर्ज';

  @override
  String get periodTitle => 'चक्र';

  @override
  String periodDaysUntil(int days) {
    return '$days दिनों में माहवारी';
  }

  @override
  String get periodFertile => 'उपजाऊ';

  @override
  String get periodNotFertile => 'अनुपजाऊ';

  @override
  String get periodOvulation => 'ओव्यूलेशन';

  @override
  String get periodEnterPeriod => 'माहवारी दर्ज करें';

  @override
  String get periodEnterSymptoms => 'लक्षण दर्ज करें';

  @override
  String get periodPregnancyChance => 'गर्भावस्था की संभावना';

  @override
  String get periodCalendar => 'कैलेंडर';

  @override
  String get periodMyCycles => 'मेरे चक्र';

  @override
  String get periodCycleTrends => 'चक्र रुझान';

  @override
  String get planningTitle => 'योजना';

  @override
  String get planningCalendar => 'कैलेंडर';

  @override
  String get planningTodos => 'कार्य';

  @override
  String get planningGoals => 'लक्ष्य';

  @override
  String get planningHabits => 'आदतें';

  @override
  String get planningAddAppointment => 'अपॉइंटमेंट जोड़ें';

  @override
  String get planningAddTodo => 'कार्य जोड़ें';

  @override
  String get planningAddGoal => 'लक्ष्य जोड़ें';

  @override
  String get planningAddHabit => 'आदत जोड़ें';

  @override
  String get planningShowAll => 'सभी दिखाएं';

  @override
  String get planningDueDate => 'नियत तारीख';

  @override
  String get planningPriorityHigh => 'उच्च';

  @override
  String get planningPriorityMedium => 'मध्यम';

  @override
  String get planningPriorityLow => 'निम्न';

  @override
  String planningStreakDays(int days) {
    return '$days दिन';
  }

  @override
  String planningLongestStreak(int days) {
    return 'सबसे लंबी स्ट्रीक: $days दिन';
  }

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsAppearance => 'दिखावट';

  @override
  String get settingsTheme => 'थीम';

  @override
  String get settingsThemeDark => 'डार्क';

  @override
  String get settingsThemeLight => 'लाइट';

  @override
  String get settingsThemeSystem => 'सिस्टम';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsUnits => 'इकाइयाँ';

  @override
  String get settingsWeightUnit => 'वजन';

  @override
  String get settingsLengthUnit => 'लंबाई';

  @override
  String get settingsTempUnit => 'तापमान';

  @override
  String get settingsNotifications => 'सूचनाएं';

  @override
  String get settingsPrivacy => 'गोपनीयता और सुरक्षा';

  @override
  String get settingsPinBiometric => 'PIN / बायोमेट्रिक';

  @override
  String get settingsExportData => 'डेटा निर्यात करें';

  @override
  String get settingsBackup => 'बैकअप बनाएं';

  @override
  String get settingsRestore => 'बैकअप पुनर्स्थापित करें';

  @override
  String get settingsWeather => 'मौसम';

  @override
  String get settingsNavigation => 'नेविगेशन कस्टमाइज़ करें';

  @override
  String get settingsAccount => 'खाता और ऐप';

  @override
  String get settingsPeriodTracking => 'माहवारी ट्रैकिंग';

  @override
  String get settingsResetOnboarding => 'परिचय दोहराएं';

  @override
  String get settingsDeleteAllData => 'सभी डेटा हटाएं';

  @override
  String get settingsDeleteConfirmTitle => 'सभी डेटा हटाएं?';

  @override
  String get settingsDeleteConfirmHint => 'पुष्टि के लिए DELETE टाइप करें';

  @override
  String get settingsWidgets => 'विजेट';

  @override
  String get settingsSupport => 'सहायता';

  @override
  String get settingsVersion => 'ऐप संस्करण';

  @override
  String get supportBugReport => 'बग रिपोर्ट करें';

  @override
  String get supportEmailCopied => 'ईमेल कॉपी किया: support@traum-app.de';

  @override
  String get supportBugReportHint =>
      'आपका ईमेल ऐप एक पूर्व-भरे ड्राफ्ट के साथ खुलेगा।';

  @override
  String get onboardingWelcomeTitle => 'TRAUM में आपका स्वागत है';

  @override
  String get onboardingWelcomeSubtitle =>
      'आपका व्यक्तिगत सिस्टम। सब कुछ एक जगह।';

  @override
  String get onboardingProfileTitle => 'आपकी प्रोफ़ाइल';

  @override
  String get onboardingProfilePrivacyNote =>
      'निम्नलिखित जानकारी TRAUM को आपके लिए ऐप को व्यक्तिगत बनाने में मदद करती है। सभी डेटा आपके डिवाइस पर रहता है।';

  @override
  String get onboardingNameLabel => 'हम आपको क्या बुलाएं?';

  @override
  String get onboardingNameHint => 'आपका नाम';

  @override
  String get onboardingBirthday => 'जन्मदिन (वैकल्पिक)';

  @override
  String get onboardingBiologicalSex => 'जैविक लिंग';

  @override
  String get onboardingSexMale => 'पुरुष';

  @override
  String get onboardingSexFemale => 'महिला';

  @override
  String get onboardingSexNone => 'बताना नहीं चाहते';

  @override
  String get onboardingPeriodActivated =>
      'माहवारी ट्रैकिंग आपके लिए सक्रिय की जाएगी।';

  @override
  String get onboardingUnits => 'इकाइयाँ';

  @override
  String get onboardingFitnessTitle => 'फिटनेस और स्वास्थ्य';

  @override
  String get onboardingStepsGoal => 'दैनिक कदम लक्ष्य';

  @override
  String get onboardingCurrentWeight => 'वर्तमान वजन';

  @override
  String get onboardingTargetWeight => 'लक्ष्य वजन';

  @override
  String get onboardingHeight => 'ऊंचाई';

  @override
  String get onboardingNutritionTitle => 'पोषण';

  @override
  String get onboardingCalorieGoal => 'दैनिक कैलोरी लक्ष्य';

  @override
  String get onboardingProteinGoal => 'दैनिक प्रोटीन लक्ष्य (ग्राम)';

  @override
  String get onboardingWaterGoal => 'दैनिक पानी लक्ष्य (मिली)';

  @override
  String get onboardingNutritionHint =>
      'आप इन मानों को कभी भी सेटिंग्स में बदल सकते हैं।';

  @override
  String get onboardingPeriodTitle => 'आपका चक्र';

  @override
  String get onboardingPeriodSubtitle =>
      'TRAUM आपके चक्र, उपजाऊ दिनों की गणना करता है — बिना क्लाउड, बिना साझाकरण।';

  @override
  String get onboardingLastPeriodStart => 'पिछली माहवारी का पहला दिन';

  @override
  String get onboardingCycleLength => 'औसत चक्र की लंबाई';

  @override
  String get onboardingPeriodLength => 'औसत माहवारी की लंबाई';

  @override
  String get onboardingPeriodSetup => 'सेट अप करें';

  @override
  String get onboardingPeriodLater => 'बाद में सेट करें';

  @override
  String get onboardingNavTitle => 'आपका नेविगेशन';

  @override
  String get onboardingNavSubtitle =>
      'चुनें कि नेविगेशन बार में कौन से मॉड्यूल दिखाई दें।';

  @override
  String get onboardingHealthTitle => 'स्वास्थ्य डेटा';

  @override
  String get onboardingHealthAndroid =>
      'TRAUM Health Connect से कदम, नींद और हृदय गति स्वचालित रूप से पढ़ सकता है।';

  @override
  String get onboardingHealthIOS =>
      'TRAUM Apple Health से कदम, नींद और हृदय गति स्वचालित रूप से पढ़ सकता है।';

  @override
  String get onboardingHealthAllow => 'एक्सेस दें';

  @override
  String get onboardingHealthSkip => 'बाद में';

  @override
  String get onboardingNotifTitle => 'सूचनाएं';

  @override
  String get onboardingNotifSubtitle =>
      'दवाइयों, पानी और कार्यों के लिए अनुस्मारक।';

  @override
  String get onboardingNotifAllow => 'सूचनाएं सक्रिय करें';

  @override
  String get onboardingNotifSkip => 'नहीं, धन्यवाद';

  @override
  String get onboardingDoneTitle => 'सब तैयार है।';

  @override
  String get onboardingDoneSubtitle =>
      'आपका सिस्टम तैयार है। आप कभी भी सभी सेटिंग्स बदल सकते हैं।';

  @override
  String get onboardingDoneHint => 'आपका डेटा इस डिवाइस से कभी नहीं जाएगा।';

  @override
  String get onboardingNext => 'आगे';

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingFinish => 'शुरू करें';

  @override
  String get commonSave => 'सहेजें';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonDelete => 'हटाएं';

  @override
  String get commonEdit => 'संपादित करें';

  @override
  String get commonAdd => 'जोड़ें';

  @override
  String get commonConfirm => 'पुष्टि करें';

  @override
  String get commonClose => 'बंद करें';

  @override
  String get commonBack => 'वापस';

  @override
  String get commonShowAll => 'सभी दिखाएं';

  @override
  String get commonNoData => 'कोई डेटा नहीं';

  @override
  String get commonLoading => 'लोड हो रहा है…';

  @override
  String get commonError => 'त्रुटि हुई';

  @override
  String get commonSuccess => 'सफलतापूर्वक सहेजा गया';

  @override
  String commonDays(int count) {
    return '$count दिन';
  }

  @override
  String commonHours(int count) {
    return '$count घंटे';
  }

  @override
  String commonMinutes(int count) {
    return '$count मिनट';
  }

  @override
  String get notifMedication => 'दवाई';

  @override
  String get notifSupplement => 'सप्लीमेंट';

  @override
  String get notifWorkout => 'ट्रेनिंग';

  @override
  String get notifWater => 'पानी';

  @override
  String get notifTodo => 'कार्य';

  @override
  String get notifHabit => 'आदतें';

  @override
  String get notifCalendar => 'कैलेंडर';

  @override
  String get notifHealth => 'स्वास्थ्य';

  @override
  String get notifBudget => 'बजट';

  @override
  String get notifPeriod => 'चक्र';

  @override
  String get exercise_bench_press => 'बेंच प्रेस';

  @override
  String get exercise_push_up => 'पुश-अप';

  @override
  String get exercise_pull_up => 'पुल-अप';

  @override
  String get exercise_squat => 'स्क्वाट';

  @override
  String get exercise_deadlift => 'डेडलिफ्ट';

  @override
  String get exercise_shoulder_press => 'शोल्डर प्रेस';

  @override
  String get exercise_bicep_curl => 'बाइसेप कर्ल';

  @override
  String get exercise_tricep_dip => 'ट्राइसेप डिप';

  @override
  String get exercise_plank => 'प्लैंक';

  @override
  String get exercise_running => 'दौड़';

  @override
  String get exercise_incline_press => 'इन्क्लाइन प्रेस';

  @override
  String get exercise_chest_fly => 'चेस्ट फ्लाई';

  @override
  String get exercise_cable_crossover => 'केबल क्रॉसओवर';

  @override
  String get exercise_dip => 'डिप';

  @override
  String get exercise_lat_pulldown => 'लैट पुलडाउन';

  @override
  String get exercise_bent_row => 'बेंट रो';

  @override
  String get exercise_seated_row => 'सीटेड रो';

  @override
  String get exercise_pullover => 'पुलओवर';

  @override
  String get exercise_face_pull => 'फेस पुल';

  @override
  String get exercise_lateral_raise => 'लेटरल रेज';

  @override
  String get exercise_front_raise => 'फ्रंट रेज';

  @override
  String get exercise_rear_delt_fly => 'रियर डेल्ट फ्लाई';

  @override
  String get exercise_hammer_curl => 'हैमर कर्ल';

  @override
  String get exercise_concentration_curl => 'कंसेंट्रेशन कर्ल';

  @override
  String get exercise_skull_crusher => 'स्कल क्रशर';

  @override
  String get exercise_overhead_tricep => 'ओवरहेड ट्राइसेप';

  @override
  String get exercise_leg_press => 'लेग प्रेस';

  @override
  String get exercise_leg_curl => 'लेग कर्ल';

  @override
  String get exercise_leg_extension => 'लेग एक्सटेंशन';

  @override
  String get exercise_calf_raise => 'काफ रेज';

  @override
  String get exercise_lunge => 'लंज';

  @override
  String get exercise_glute_bridge => 'ग्लूट ब्रिज';

  @override
  String get exercise_crunch => 'क्रंच';

  @override
  String get exercise_russian_twist => 'रशियन ट्विस्ट';

  @override
  String get exercise_leg_raise => 'लेग रेज';

  @override
  String get exercise_mountain_climber => 'माउंटेन क्लाइंबर';

  @override
  String get exercise_bicycle_crunch => 'बाइसिकल क्रंच';

  @override
  String get exercise_cycling => 'साइकिलिंग';

  @override
  String get exercise_rowing => 'रोइंग';

  @override
  String get exercise_jump_rope => 'जंप रोप';

  @override
  String get exercise_burpee => 'बर्पी';

  @override
  String get exercise_jumping_jack => 'जंपिंग जैक';

  @override
  String get exercise_clean => 'क्लीन';

  @override
  String get exercise_snatch => 'स्नैच';

  @override
  String get exercise_thruster => 'थ्रस्टर';

  @override
  String get exercise_box_jump => 'बॉक्स जंप';

  @override
  String get exercise_battle_rope => 'बैटल रोप';

  @override
  String get supplement_vitamin_d3 => 'विटामिन D3';

  @override
  String get supplement_vitamin_c => 'विटामिन C';

  @override
  String get supplement_vitamin_b12 => 'विटामिन B12';

  @override
  String get supplement_vitamin_a => 'विटामिन A';

  @override
  String get supplement_vitamin_e => 'विटामिन E';

  @override
  String get supplement_vitamin_k2 => 'विटामिन K2';

  @override
  String get supplement_vitamin_b_complex => 'विटामिन B कॉम्प्लेक्स';

  @override
  String get supplement_magnesium => 'मैग्नीशियम';

  @override
  String get supplement_zinc => 'जिंक';

  @override
  String get supplement_iron => 'आयरन';

  @override
  String get supplement_calcium => 'कैल्शियम';

  @override
  String get supplement_selenium => 'सेलेनियम';

  @override
  String get supplement_creatine => 'क्रिएटिन';

  @override
  String get supplement_l_glutamine => 'L-ग्लूटामाइन';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-अर्जिनीन';

  @override
  String get supplement_whey_protein => 'व्हे प्रोटीन';

  @override
  String get supplement_casein => 'कैसिन';

  @override
  String get supplement_vegan_protein => 'वेगन प्रोटीन';

  @override
  String get supplement_omega3 => 'ओमेगा-3';

  @override
  String get supplement_fish_oil => 'फिश ऑयल';

  @override
  String get supplement_ashwagandha => 'अश्वगंधा';

  @override
  String get supplement_rhodiola => 'रोडियोला';

  @override
  String get supplement_caffeine => 'कैफीन';

  @override
  String get supplement_beta_alanine => 'बीटा-अलानिन';

  @override
  String get supplement_citrulline => 'सिट्रुलाइन';

  @override
  String get supplement_probiotics => 'प्रोबायोटिक्स';

  @override
  String get supplement_prebiotics => 'प्रीबायोटिक्स';

  @override
  String get weatherClear => 'साफ';

  @override
  String get weatherMostlyClear => 'अधिकतर साफ';

  @override
  String get weatherPartlyCloudy => 'आंशिक बादल';

  @override
  String get weatherOvercast => 'बादलयुक्त';

  @override
  String get weatherFoggy => 'कोहरा';

  @override
  String get weatherDrizzle => 'बूंदाबांदी';

  @override
  String get weatherRain => 'बारिश';

  @override
  String get weatherSnowfall => 'हिमपात';

  @override
  String get weatherSnowGrains => 'बर्फ के कण';

  @override
  String get weatherRainShowers => 'बारिश की फुहारें';

  @override
  String get weatherSnowShowers => 'बर्फ की फुहारें';

  @override
  String get weatherThunderstorm => 'आंधी-तूफान';

  @override
  String get weatherHeavyThunderstorm => 'भारी आंधी-तूफान';
}
