// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String greetingMorning(String name) {
    return 'صباح الخير، $name!';
  }

  @override
  String greetingDay(String name) {
    return 'مساء الخير، $name!';
  }

  @override
  String greetingEvening(String name) {
    return 'مساء النور، $name!';
  }

  @override
  String greetingNight(String name) {
    return 'تصبح على خير، $name!';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal خطوة';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal سعرة';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal جرام بروتين';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal مل';
  }

  @override
  String get homeBudgetAvailable => 'الرصيد المتاح';

  @override
  String get homeNoAppointments => 'لا مواعيد اليوم';

  @override
  String get homeNoGoal => 'لا هدف نشط';

  @override
  String get homeTodayLabel => 'اليوم';

  @override
  String homeHabitsStreak(int days) {
    return 'تسلسل $days أيام';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'و$count آخرون';
  }

  @override
  String get homeHealthSleep => 'النوم';

  @override
  String get homeHealthHeartRate => 'معدل ضربات القلب';

  @override
  String get homeHealthMood => 'المزاج';

  @override
  String get homeWaterAdd200 => '+200 مل';

  @override
  String get homeWaterAdd300 => '+300 مل';

  @override
  String get homeWaterAdd500 => '+500 مل';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navTraining => 'التدريب';

  @override
  String get navHealth => 'الصحة';

  @override
  String get navNutrition => 'التغذية';

  @override
  String get navMore => 'المزيد';

  @override
  String get navPlanning => 'التخطيط';

  @override
  String get navMedication => 'الدواء';

  @override
  String get navSupplements => 'المكملات';

  @override
  String get navAbstinence => 'الامتناع';

  @override
  String get navBudget => 'الميزانية';

  @override
  String get navPeriod => 'الدورة';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get trainingStart => 'بدء التمرين';

  @override
  String get trainingHistory => 'سجل التدريب';

  @override
  String get trainingLastWorkout => 'آخر تمرين';

  @override
  String get trainingActiveplan => 'الخطة النشطة';

  @override
  String get trainingExerciseLibrary => 'مكتبة التمارين';

  @override
  String get trainingExerciseProgress => 'تقدم التمرين';

  @override
  String get trainingVolume => 'الحجم';

  @override
  String get trainingDuration => 'المدة';

  @override
  String trainingSetCount(int current, int total) {
    return 'المجموعة $current من $total';
  }

  @override
  String get trainingRestTimer => 'راحة';

  @override
  String get trainingWorkoutSummary => 'اكتمل التمرين';

  @override
  String get trainingAddExercise => 'إضافة تمرين';

  @override
  String get trainingCustomExercise => 'تمرين مخصص';

  @override
  String get healthTitle => 'الصحة';

  @override
  String get healthOverview => 'نظرة عامة';

  @override
  String get healthSleep => 'النوم';

  @override
  String get healthWeight => 'الوزن';

  @override
  String get healthBodyMeasurements => 'قياسات الجسم';

  @override
  String get healthSteps7Days => 'اتجاه 7 أيام';

  @override
  String get healthSleepManual => 'إدخال يدوي';

  @override
  String get healthSleepQuality => 'جودة النوم';

  @override
  String get healthWeightGoal => 'الوزن المستهدف';

  @override
  String get healthHeartRate => 'معدل ضربات القلب أثناء الراحة';

  @override
  String get healthConnectPermission => 'إذن Health Connect';

  @override
  String get healthKitPermission => 'إذن Apple Health';

  @override
  String get healthNoData => 'لا توجد بيانات';

  @override
  String get nutritionTitle => 'التغذية';

  @override
  String get nutritionCalories => 'السعرات';

  @override
  String get nutritionProtein => 'البروتين';

  @override
  String get nutritionCarbs => 'الكربوهيدرات';

  @override
  String get nutritionFat => 'الدهون';

  @override
  String get nutritionWater => 'الماء';

  @override
  String get nutritionAddMeal => 'إضافة وجبة';

  @override
  String get nutritionSaveTemplate => 'حفظ كقالب';

  @override
  String get nutritionShoppingList => 'قائمة التسوق';

  @override
  String get supplementTitle => 'المكملات';

  @override
  String get supplementAdd => 'إضافة مكمل';

  @override
  String get supplementTaken => 'تم التناول';

  @override
  String get supplementPending => 'معلق';

  @override
  String get supplementHistory => 'السجل';

  @override
  String get medicationTitle => 'الدواء';

  @override
  String get medicationAdd => 'إضافة دواء';

  @override
  String get medicationTaken => 'تم التناول';

  @override
  String get medicationDose => 'الجرعة';

  @override
  String get medicationCompliance => 'الالتزام';

  @override
  String get abstinenceTitle => 'الامتناع';

  @override
  String get abstinenceAdd => 'إضافة متتبع';

  @override
  String abstinenceDays(int days) {
    return '$days أيام';
  }

  @override
  String get abstinenceRelapse => 'انتكاسة';

  @override
  String get abstinenceRelapseConfirm => 'تأكيد الانتكاسة';

  @override
  String get abstinenceRelapseNote => 'ملاحظة (اختياري)';

  @override
  String get abstinenceLongestStreak => 'أطول تسلسل';

  @override
  String get abstinenceLastRelapse => 'آخر انتكاسة';

  @override
  String get budgetTitle => 'الميزانية';

  @override
  String get budgetAvailable => 'الرصيد المتاح';

  @override
  String get budgetIncome => 'الدخل';

  @override
  String get budgetExpenses => 'المصروفات';

  @override
  String get budgetCategoryExpenses => 'المصروفات حسب الفئة';

  @override
  String get budgetVsLimit => 'الميزانية مقابل المصروفات';

  @override
  String budgetOverrun(String category) {
    return 'تجاوزت $category!';
  }

  @override
  String get budgetAddTransaction => 'إضافة معاملة';

  @override
  String get budgetSavings => 'أهداف الادخار';

  @override
  String get budgetDebts => 'الديون';

  @override
  String get periodTitle => 'الدورة';

  @override
  String periodDaysUntil(int days) {
    return 'الدورة بعد $days أيام';
  }

  @override
  String get periodFertile => 'خصبة';

  @override
  String get periodNotFertile => 'غير خصبة';

  @override
  String get periodOvulation => 'الإباضة';

  @override
  String get periodEnterPeriod => 'تسجيل الدورة';

  @override
  String get periodEnterSymptoms => 'تسجيل الأعراض';

  @override
  String get periodPregnancyChance => 'احتمالية الحمل';

  @override
  String get periodCalendar => 'التقويم';

  @override
  String get periodMyCycles => 'دوراتي';

  @override
  String get periodCycleTrends => 'اتجاهات الدورة';

  @override
  String get planningTitle => 'التخطيط';

  @override
  String get planningCalendar => 'التقويم';

  @override
  String get planningTodos => 'المهام';

  @override
  String get planningGoals => 'الأهداف';

  @override
  String get planningHabits => 'العادات';

  @override
  String get planningAddAppointment => 'إضافة موعد';

  @override
  String get planningAddTodo => 'إضافة مهمة';

  @override
  String get planningAddGoal => 'إضافة هدف';

  @override
  String get planningAddHabit => 'إضافة عادة';

  @override
  String get planningShowAll => 'عرض الكل';

  @override
  String get planningDueDate => 'الموعد النهائي';

  @override
  String get planningPriorityHigh => 'عالية';

  @override
  String get planningPriorityMedium => 'متوسطة';

  @override
  String get planningPriorityLow => 'منخفضة';

  @override
  String planningStreakDays(int days) {
    return '$days أيام';
  }

  @override
  String planningLongestStreak(int days) {
    return 'أطول تسلسل: $days أيام';
  }

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsTheme => 'السمة';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsUnits => 'الوحدات';

  @override
  String get settingsWeightUnit => 'الوزن';

  @override
  String get settingsLengthUnit => 'الطول';

  @override
  String get settingsTempUnit => 'درجة الحرارة';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsPrivacy => 'الخصوصية والأمان';

  @override
  String get settingsPinBiometric => 'PIN / القياسات الحيوية';

  @override
  String get settingsExportData => 'تصدير البيانات';

  @override
  String get settingsBackup => 'إنشاء نسخة احتياطية';

  @override
  String get settingsRestore => 'استعادة النسخة';

  @override
  String get settingsWeather => 'الطقس';

  @override
  String get settingsNavigation => 'تخصيص التنقل';

  @override
  String get settingsAccount => 'الحساب والتطبيق';

  @override
  String get settingsPeriodTracking => 'تتبع الدورة';

  @override
  String get settingsResetOnboarding => 'إعادة المقدمة';

  @override
  String get settingsDeleteAllData => 'حذف جميع البيانات';

  @override
  String get settingsDeleteConfirmTitle => 'هل تريد حذف جميع البيانات؟';

  @override
  String get settingsDeleteConfirmHint => 'اكتب DELETE للتأكيد';

  @override
  String get settingsWidgets => 'الأدوات';

  @override
  String get settingsSupport => 'الدعم';

  @override
  String get settingsVersion => 'الإصدار';

  @override
  String get supportBugReport => 'الإبلاغ عن خطأ';

  @override
  String get supportEmailCopied =>
      'تم نسخ البريد الإلكتروني: support@traum-app.de';

  @override
  String get supportBugReportHint => 'سيفتح تطبيق البريد الإلكتروني مع مسودة.';

  @override
  String get onboardingWelcomeTitle => 'مرحباً بك في TRAUM';

  @override
  String get onboardingWelcomeSubtitle => 'نظامك الشخصي. كل شيء في مكان واحد.';

  @override
  String get onboardingProfileTitle => 'ملفك الشخصي';

  @override
  String get onboardingProfilePrivacyNote =>
      'تساعد المعلومات التالية TRAUM على تخصيص التطبيق. جميع البيانات تبقى على جهازك.';

  @override
  String get onboardingNameLabel => 'كيف نناديك؟';

  @override
  String get onboardingNameHint => 'اسمك';

  @override
  String get onboardingBirthday => 'تاريخ الميلاد (اختياري)';

  @override
  String get onboardingBiologicalSex => 'الجنس البيولوجي';

  @override
  String get onboardingSexMale => 'ذكر';

  @override
  String get onboardingSexFemale => 'أنثى';

  @override
  String get onboardingSexNone => 'أفضل عدم الإفصاح';

  @override
  String get onboardingPeriodActivated => 'سيتم تفعيل تتبع الدورة لك.';

  @override
  String get onboardingUnits => 'الوحدات';

  @override
  String get onboardingFitnessTitle => 'اللياقة والصحة';

  @override
  String get onboardingStepsGoal => 'هدف الخطوات اليومي';

  @override
  String get onboardingCurrentWeight => 'الوزن الحالي';

  @override
  String get onboardingTargetWeight => 'الوزن المستهدف';

  @override
  String get onboardingHeight => 'الطول';

  @override
  String get onboardingNutritionTitle => 'التغذية';

  @override
  String get onboardingCalorieGoal => 'هدف السعرات اليومي';

  @override
  String get onboardingProteinGoal => 'هدف البروتين اليومي (جرام)';

  @override
  String get onboardingWaterGoal => 'هدف الماء اليومي (مل)';

  @override
  String get onboardingNutritionHint =>
      'يمكنك ضبط هذه القيم في الإعدادات في أي وقت.';

  @override
  String get onboardingPeriodTitle => 'دورتك';

  @override
  String get onboardingPeriodSubtitle =>
      'يحسب TRAUM دورتك وأوقات الخصوبة ويعطيك معلومات يومية — بدون سحابة، بدون مشاركة.';

  @override
  String get onboardingLastPeriodStart => 'أول يوم من آخر دورة';

  @override
  String get onboardingCycleLength => 'متوسط طول الدورة';

  @override
  String get onboardingPeriodLength => 'متوسط طول الحيض';

  @override
  String get onboardingPeriodSetup => 'إعداد';

  @override
  String get onboardingPeriodLater => 'إعداد لاحقاً';

  @override
  String get onboardingNavTitle => 'تنقلك';

  @override
  String get onboardingNavSubtitle => 'اختر الوحدات التي تظهر في شريط التنقل.';

  @override
  String get onboardingHealthTitle => 'بيانات الصحة';

  @override
  String get onboardingHealthAndroid =>
      'يمكن لـ TRAUM قراءة الخطوات والنوم ومعدل ضربات القلب تلقائياً من Health Connect.';

  @override
  String get onboardingHealthIOS =>
      'يمكن لـ TRAUM قراءة الخطوات والنوم ومعدل ضربات القلب تلقائياً من Apple Health.';

  @override
  String get onboardingHealthAllow => 'السماح بالوصول';

  @override
  String get onboardingHealthSkip => 'لاحقاً';

  @override
  String get onboardingNotifTitle => 'الإشعارات';

  @override
  String get onboardingNotifSubtitle => 'تذكيرات للأدوية والماء والمهام.';

  @override
  String get onboardingNotifAllow => 'تفعيل الإشعارات';

  @override
  String get onboardingNotifSkip => 'لا شكراً';

  @override
  String get onboardingDoneTitle => 'كل شيء جاهز.';

  @override
  String get onboardingDoneSubtitle =>
      'نظامك ينتظرك. يمكنك ضبط جميع الإعدادات في أي وقت.';

  @override
  String get onboardingDoneHint => 'بياناتك لن تغادر هذا الجهاز أبداً.';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingFinish => 'لنبدأ';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonAdd => 'إضافة';

  @override
  String get commonConfirm => 'تأكيد';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonShowAll => 'عرض الكل';

  @override
  String get commonNoData => 'لا توجد بيانات';

  @override
  String get commonLoading => 'جار التحميل…';

  @override
  String get commonError => 'حدث خطأ';

  @override
  String get commonSuccess => 'تم الحفظ بنجاح';

  @override
  String commonDays(int count) {
    return '$count أيام';
  }

  @override
  String commonHours(int count) {
    return '$count ساعات';
  }

  @override
  String commonMinutes(int count) {
    return '$count دقائق';
  }

  @override
  String get notifMedication => 'الدواء';

  @override
  String get notifSupplement => 'المكملات';

  @override
  String get notifWorkout => 'التدريب';

  @override
  String get notifWater => 'الماء';

  @override
  String get notifTodo => 'المهام';

  @override
  String get notifHabit => 'العادات';

  @override
  String get notifCalendar => 'التقويم';

  @override
  String get notifHealth => 'الصحة';

  @override
  String get notifBudget => 'الميزانية';

  @override
  String get notifPeriod => 'الدورة';

  @override
  String get exercise_bench_press => 'الضغط على المقعد';

  @override
  String get exercise_push_up => 'تمرين الضغط';

  @override
  String get exercise_pull_up => 'العقلة';

  @override
  String get exercise_squat => 'القرفصاء';

  @override
  String get exercise_deadlift => 'الرفعة الميتة';

  @override
  String get exercise_shoulder_press => 'ضغط الكتفين';

  @override
  String get exercise_bicep_curl => 'تمرين الثنيات';

  @override
  String get exercise_tricep_dip => 'تمرين الثلاثية';

  @override
  String get exercise_plank => 'البلانك';

  @override
  String get exercise_running => 'الجري';

  @override
  String get exercise_incline_press => 'الضغط المائل';

  @override
  String get exercise_chest_fly => 'فتح الصدر';

  @override
  String get exercise_cable_crossover => 'تقاطع الكابل';

  @override
  String get exercise_dip => 'الغطس';

  @override
  String get exercise_lat_pulldown => 'السحب العلوي';

  @override
  String get exercise_bent_row => 'التجديف المنحني';

  @override
  String get exercise_seated_row => 'التجديف الجالس';

  @override
  String get exercise_pullover => 'البولأوفر';

  @override
  String get exercise_face_pull => 'سحب الوجه';

  @override
  String get exercise_lateral_raise => 'الرفع الجانبي';

  @override
  String get exercise_front_raise => 'الرفع الأمامي';

  @override
  String get exercise_rear_delt_fly => 'فتح الكتف الخلفي';

  @override
  String get exercise_hammer_curl => 'الثنيات المطرقية';

  @override
  String get exercise_concentration_curl => 'الثنيات المركزة';

  @override
  String get exercise_skull_crusher => 'تمرين الجمجمة';

  @override
  String get exercise_overhead_tricep => 'مد الثلاثية فوق الرأس';

  @override
  String get exercise_leg_press => 'ضغط الساق';

  @override
  String get exercise_leg_curl => 'ثني الساق';

  @override
  String get exercise_leg_extension => 'مد الساق';

  @override
  String get exercise_calf_raise => 'رفع الكعب';

  @override
  String get exercise_lunge => 'الخطوة الواسعة';

  @override
  String get exercise_glute_bridge => 'جسر الأرداف';

  @override
  String get exercise_crunch => 'الانقباضات';

  @override
  String get exercise_russian_twist => 'اللف الروسي';

  @override
  String get exercise_leg_raise => 'رفع الساق';

  @override
  String get exercise_mountain_climber => 'متسلق الجبل';

  @override
  String get exercise_bicycle_crunch => 'دراجة البطن';

  @override
  String get exercise_cycling => 'ركوب الدراجة';

  @override
  String get exercise_rowing => 'التجديف';

  @override
  String get exercise_jump_rope => 'تخطي الحبل';

  @override
  String get exercise_burpee => 'البيربي';

  @override
  String get exercise_jumping_jack => 'القفز المتفرق';

  @override
  String get exercise_clean => 'الكلين';

  @override
  String get exercise_snatch => 'الانتزاع';

  @override
  String get exercise_thruster => 'الثراستر';

  @override
  String get exercise_box_jump => 'القفز على الصندوق';

  @override
  String get exercise_battle_rope => 'حبل المعركة';

  @override
  String get supplement_vitamin_d3 => 'فيتامين د3';

  @override
  String get supplement_vitamin_c => 'فيتامين ج';

  @override
  String get supplement_vitamin_b12 => 'فيتامين ب12';

  @override
  String get supplement_vitamin_a => 'فيتامين أ';

  @override
  String get supplement_vitamin_e => 'فيتامين هـ';

  @override
  String get supplement_vitamin_k2 => 'فيتامين ك2';

  @override
  String get supplement_vitamin_b_complex => 'مركب فيتامين ب';

  @override
  String get supplement_magnesium => 'المغنيسيوم';

  @override
  String get supplement_zinc => 'الزنك';

  @override
  String get supplement_iron => 'الحديد';

  @override
  String get supplement_calcium => 'الكالسيوم';

  @override
  String get supplement_selenium => 'السيلينيوم';

  @override
  String get supplement_creatine => 'الكرياتين';

  @override
  String get supplement_l_glutamine => 'ل-جلوتامين';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'ل-أرجينين';

  @override
  String get supplement_whey_protein => 'بروتين مصل اللبن';

  @override
  String get supplement_casein => 'الكازين';

  @override
  String get supplement_vegan_protein => 'بروتين نباتي';

  @override
  String get supplement_omega3 => 'أوميجا-3';

  @override
  String get supplement_fish_oil => 'زيت السمك';

  @override
  String get supplement_ashwagandha => 'أشواغاندا';

  @override
  String get supplement_rhodiola => 'روديولا';

  @override
  String get supplement_caffeine => 'الكافيين';

  @override
  String get supplement_beta_alanine => 'بيتا-ألانين';

  @override
  String get supplement_citrulline => 'سيترولين';

  @override
  String get supplement_probiotics => 'البروبيوتيك';

  @override
  String get supplement_prebiotics => 'البريبيوتيك';
}
