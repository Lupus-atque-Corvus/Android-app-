// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String greetingMorning(String name) {
    return '早上好，$name！';
  }

  @override
  String greetingDay(String name) {
    return '下午好，$name！';
  }

  @override
  String greetingEvening(String name) {
    return '晚上好，$name！';
  }

  @override
  String greetingNight(String name) {
    return '晚安，$name！';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal 步';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal 千卡';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal 克蛋白质';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal 毫升';
  }

  @override
  String get homeBudgetAvailable => '可用余额';

  @override
  String get homeNoAppointments => '今天没有约会';

  @override
  String get homeNoGoal => '没有活跃目标';

  @override
  String get homeTodayLabel => '今天';

  @override
  String homeHabitsStreak(int days) {
    return '$days 天连续';
  }

  @override
  String homeAbstinenceMore(int count) {
    return '还有 $count 个';
  }

  @override
  String get homeHealthSleep => '睡眠';

  @override
  String get homeHealthHeartRate => '心率';

  @override
  String get homeHealthMood => '情绪';

  @override
  String get homeWaterAdd200 => '+200 毫升';

  @override
  String get homeWaterAdd300 => '+300 毫升';

  @override
  String get homeWaterAdd500 => '+500 毫升';

  @override
  String get navHome => '主页';

  @override
  String get navTraining => '训练';

  @override
  String get navHealth => '健康';

  @override
  String get navNutrition => '营养';

  @override
  String get navMore => '更多';

  @override
  String get navPlanning => '计划';

  @override
  String get navMedication => '药物';

  @override
  String get navSupplements => '补剂';

  @override
  String get navAbstinence => '戒断';

  @override
  String get navBudget => '预算';

  @override
  String get navPeriod => '周期';

  @override
  String get navSettings => '设置';

  @override
  String get trainingStart => '开始训练';

  @override
  String get trainingHistory => '训练历史';

  @override
  String get trainingLastWorkout => '上次训练';

  @override
  String get trainingActiveplan => '当前计划';

  @override
  String get trainingExerciseLibrary => '动作库';

  @override
  String get trainingExerciseProgress => '动作进步';

  @override
  String get trainingVolume => '训练量';

  @override
  String get trainingDuration => '时长';

  @override
  String trainingSetCount(int current, int total) {
    return '第 $current 组 / 共 $total 组';
  }

  @override
  String get trainingRestTimer => '休息';

  @override
  String get trainingWorkoutSummary => '训练完成';

  @override
  String get trainingAddExercise => '添加动作';

  @override
  String get trainingCustomExercise => '自定义动作';

  @override
  String get healthTitle => '健康';

  @override
  String get healthOverview => '概览';

  @override
  String get healthSleep => '睡眠';

  @override
  String get healthWeight => '体重';

  @override
  String get healthBodyMeasurements => '身体测量';

  @override
  String get healthSteps7Days => '7天趋势';

  @override
  String get healthSleepManual => '手动输入';

  @override
  String get healthSleepQuality => '睡眠质量';

  @override
  String get healthWeightGoal => '目标体重';

  @override
  String get healthHeartRate => '静息心率';

  @override
  String get healthConnectPermission => 'Health Connect 权限';

  @override
  String get healthKitPermission => 'Apple Health 权限';

  @override
  String get healthNoData => '暂无数据';

  @override
  String get nutritionTitle => '营养';

  @override
  String get nutritionCalories => '热量';

  @override
  String get nutritionProtein => '蛋白质';

  @override
  String get nutritionCarbs => '碳水化合物';

  @override
  String get nutritionFat => '脂肪';

  @override
  String get nutritionWater => '水';

  @override
  String get nutritionAddMeal => '添加餐食';

  @override
  String get nutritionSaveTemplate => '保存为模板';

  @override
  String get nutritionShoppingList => '购物清单';

  @override
  String get supplementTitle => '补剂';

  @override
  String get supplementAdd => '添加补剂';

  @override
  String get supplementTaken => '已服用';

  @override
  String get supplementPending => '待服用';

  @override
  String get supplementHistory => '历史';

  @override
  String get medicationTitle => '药物';

  @override
  String get medicationAdd => '添加药物';

  @override
  String get medicationTaken => '已服用';

  @override
  String get medicationDose => '剂量';

  @override
  String get medicationCompliance => '依从性';

  @override
  String get abstinenceTitle => '戒断';

  @override
  String get abstinenceAdd => '添加追踪';

  @override
  String abstinenceDays(int days) {
    return '$days 天';
  }

  @override
  String get abstinenceRelapse => '复发';

  @override
  String get abstinenceRelapseConfirm => '确认复发';

  @override
  String get abstinenceRelapseNote => '备注（可选）';

  @override
  String get abstinenceLongestStreak => '最长连续';

  @override
  String get abstinenceLastRelapse => '上次复发';

  @override
  String get budgetTitle => '预算';

  @override
  String get budgetAvailable => '可用余额';

  @override
  String get budgetIncome => '收入';

  @override
  String get budgetExpenses => '支出';

  @override
  String get budgetCategoryExpenses => '按类别支出';

  @override
  String get budgetVsLimit => '预算 vs 支出';

  @override
  String budgetOverrun(String category) {
    return '$category 超支！';
  }

  @override
  String get budgetAddTransaction => '添加交易';

  @override
  String get budgetSavings => '储蓄目标';

  @override
  String get budgetDebts => '债务';

  @override
  String get periodTitle => '周期';

  @override
  String periodDaysUntil(int days) {
    return '$days 天后来月经';
  }

  @override
  String get periodFertile => '可孕期';

  @override
  String get periodNotFertile => '非可孕期';

  @override
  String get periodOvulation => '排卵';

  @override
  String get periodEnterPeriod => '记录月经';

  @override
  String get periodEnterSymptoms => '记录症状';

  @override
  String get periodPregnancyChance => '怀孕概率';

  @override
  String get periodCalendar => '日历';

  @override
  String get periodMyCycles => '我的周期';

  @override
  String get periodCycleTrends => '周期趋势';

  @override
  String get planningTitle => '计划';

  @override
  String get planningCalendar => '日历';

  @override
  String get planningTodos => '待办';

  @override
  String get planningGoals => '目标';

  @override
  String get planningHabits => '习惯';

  @override
  String get planningAddAppointment => '添加日程';

  @override
  String get planningAddTodo => '添加任务';

  @override
  String get planningAddGoal => '添加目标';

  @override
  String get planningAddHabit => '添加习惯';

  @override
  String get planningShowAll => '显示全部';

  @override
  String get planningDueDate => '截止';

  @override
  String get planningPriorityHigh => '高';

  @override
  String get planningPriorityMedium => '中';

  @override
  String get planningPriorityLow => '低';

  @override
  String planningStreakDays(int days) {
    return '$days 天';
  }

  @override
  String planningLongestStreak(int days) {
    return '最长连续：$days 天';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsTheme => '主题';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsThemeLight => '浅色';

  @override
  String get settingsThemeSystem => '跟随系统';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsUnits => '单位';

  @override
  String get settingsWeightUnit => '重量';

  @override
  String get settingsLengthUnit => '长度';

  @override
  String get settingsTempUnit => '温度';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsPrivacy => '隐私与安全';

  @override
  String get settingsPinBiometric => 'PIN / 生物识别';

  @override
  String get settingsExportData => '导出数据';

  @override
  String get settingsBackup => '创建备份';

  @override
  String get settingsRestore => '恢复备份';

  @override
  String get settingsWeather => '天气';

  @override
  String get settingsNavigation => '自定义导航';

  @override
  String get settingsAccount => '账户与应用';

  @override
  String get settingsPeriodTracking => '月经追踪';

  @override
  String get settingsResetOnboarding => '重新引导';

  @override
  String get settingsDeleteAllData => '删除所有数据';

  @override
  String get settingsDeleteConfirmTitle => '确定删除所有数据？';

  @override
  String get settingsDeleteConfirmHint => '输入 DELETE 以确认';

  @override
  String get settingsWidgets => '小组件';

  @override
  String get settingsSupport => '支持与反馈';

  @override
  String get settingsVersion => '应用版本';

  @override
  String get supportBugReport => '报告问题';

  @override
  String get supportEmailCopied => '邮箱已复制: support@traum-app.de';

  @override
  String get supportBugReportHint => '您的邮件应用将打开预填草稿。';

  @override
  String get onboardingWelcomeTitle => '欢迎使用 TRAUM';

  @override
  String get onboardingWelcomeSubtitle => '您的个人系统。一切尽在其中。';

  @override
  String get onboardingProfileTitle => '您的个人资料';

  @override
  String get onboardingProfilePrivacyNote =>
      '以下信息帮助 TRAUM 为您个性化应用。所有数据保存在您的设备上。';

  @override
  String get onboardingNameLabel => '我们该如何称呼您？';

  @override
  String get onboardingNameHint => '您的名字';

  @override
  String get onboardingBirthday => '生日（可选）';

  @override
  String get onboardingBiologicalSex => '生理性别';

  @override
  String get onboardingSexMale => '男';

  @override
  String get onboardingSexFemale => '女';

  @override
  String get onboardingSexNone => '不愿透露';

  @override
  String get onboardingPeriodActivated => '月经追踪将为您激活。';

  @override
  String get onboardingUnits => '单位';

  @override
  String get onboardingFitnessTitle => '健康与体能';

  @override
  String get onboardingStepsGoal => '每日步数目标';

  @override
  String get onboardingCurrentWeight => '当前体重';

  @override
  String get onboardingTargetWeight => '目标体重';

  @override
  String get onboardingHeight => '身高';

  @override
  String get onboardingNutritionTitle => '营养';

  @override
  String get onboardingCalorieGoal => '每日热量目标';

  @override
  String get onboardingProteinGoal => '每日蛋白质目标（克）';

  @override
  String get onboardingWaterGoal => '每日饮水目标（毫升）';

  @override
  String get onboardingNutritionHint => '您可以随时在设置中调整这些值。';

  @override
  String get onboardingPeriodTitle => '您的周期';

  @override
  String get onboardingPeriodSubtitle =>
      'TRAUM 计算您的周期、可孕期，并提供每日相关信息——无云，无数据共享。';

  @override
  String get onboardingLastPeriodStart => '上次月经第一天';

  @override
  String get onboardingCycleLength => '平均周期长度';

  @override
  String get onboardingPeriodLength => '平均月经长度';

  @override
  String get onboardingPeriodSetup => '设置';

  @override
  String get onboardingPeriodLater => '稍后设置';

  @override
  String get onboardingNavTitle => '您的导航';

  @override
  String get onboardingNavSubtitle => '选择哪些模块出现在导航栏中。';

  @override
  String get onboardingHealthTitle => '健康数据';

  @override
  String get onboardingHealthAndroid => 'TRAUM 可从 Health Connect 自动读取步数、睡眠和心率。';

  @override
  String get onboardingHealthIOS => 'TRAUM 可从 Apple Health 自动读取步数、睡眠和心率。';

  @override
  String get onboardingHealthAllow => '允许访问';

  @override
  String get onboardingHealthSkip => '稍后';

  @override
  String get onboardingNotifTitle => '通知';

  @override
  String get onboardingNotifSubtitle => '药物、饮水和任务提醒。';

  @override
  String get onboardingNotifAllow => '启用通知';

  @override
  String get onboardingNotifSkip => '不，谢谢';

  @override
  String get onboardingDoneTitle => '一切就绪。';

  @override
  String get onboardingDoneSubtitle => '您的系统已准备好。您可以随时调整所有设置。';

  @override
  String get onboardingDoneHint => '您的数据永远不会离开此设备。';

  @override
  String get onboardingNext => '下一步';

  @override
  String get onboardingSkip => '跳过';

  @override
  String get onboardingFinish => '开始使用';

  @override
  String get commonSave => '保存';

  @override
  String get commonCancel => '取消';

  @override
  String get commonDelete => '删除';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonAdd => '添加';

  @override
  String get commonConfirm => '确认';

  @override
  String get commonClose => '关闭';

  @override
  String get commonBack => '返回';

  @override
  String get commonShowAll => '显示全部';

  @override
  String get commonNoData => '暂无数据';

  @override
  String get commonLoading => '加载中…';

  @override
  String get commonError => '发生错误';

  @override
  String get commonSuccess => '保存成功';

  @override
  String commonDays(int count) {
    return '$count 天';
  }

  @override
  String commonHours(int count) {
    return '$count 小时';
  }

  @override
  String commonMinutes(int count) {
    return '$count 分钟';
  }

  @override
  String get notifMedication => '药物';

  @override
  String get notifSupplement => '补剂';

  @override
  String get notifWorkout => '训练';

  @override
  String get notifWater => '饮水';

  @override
  String get notifTodo => '任务';

  @override
  String get notifHabit => '习惯';

  @override
  String get notifCalendar => '日历';

  @override
  String get notifHealth => '健康';

  @override
  String get notifBudget => '预算';

  @override
  String get notifPeriod => '周期';

  @override
  String get exercise_bench_press => '卧推（杠铃）';

  @override
  String get exercise_push_up => '俯卧撑';

  @override
  String get exercise_pull_up => '引体向上';

  @override
  String get exercise_squat => '深蹲';

  @override
  String get exercise_deadlift => '硬拉';

  @override
  String get exercise_shoulder_press => '肩推';

  @override
  String get exercise_bicep_curl => '弯举';

  @override
  String get exercise_tricep_dip => '三头肌撑';

  @override
  String get exercise_plank => '平板支撑';

  @override
  String get exercise_running => '跑步';

  @override
  String get exercise_incline_press => '上斜卧推';

  @override
  String get exercise_chest_fly => '飞鸟';

  @override
  String get exercise_cable_crossover => '绳索交叉';

  @override
  String get exercise_dip => '双杠臂屈伸';

  @override
  String get exercise_lat_pulldown => '高位下拉';

  @override
  String get exercise_bent_row => '俯身划船';

  @override
  String get exercise_seated_row => '坐姿划船';

  @override
  String get exercise_pullover => '直臂下拉';

  @override
  String get exercise_face_pull => '面拉';

  @override
  String get exercise_lateral_raise => '侧平举';

  @override
  String get exercise_front_raise => '前平举';

  @override
  String get exercise_rear_delt_fly => '俯身飞鸟';

  @override
  String get exercise_hammer_curl => '锤式弯举';

  @override
  String get exercise_concentration_curl => '集中弯举';

  @override
  String get exercise_skull_crusher => '颅骨破碎者';

  @override
  String get exercise_overhead_tricep => '过头三头肌伸展';

  @override
  String get exercise_leg_press => '腿举';

  @override
  String get exercise_leg_curl => '腿弯举';

  @override
  String get exercise_leg_extension => '腿伸展';

  @override
  String get exercise_calf_raise => '提踵';

  @override
  String get exercise_lunge => '弓步蹲';

  @override
  String get exercise_glute_bridge => '臀桥';

  @override
  String get exercise_crunch => '卷腹';

  @override
  String get exercise_russian_twist => '俄罗斯转体';

  @override
  String get exercise_leg_raise => '悬挂举腿';

  @override
  String get exercise_mountain_climber => '登山者';

  @override
  String get exercise_bicycle_crunch => '自行车卷腹';

  @override
  String get exercise_cycling => '骑自行车';

  @override
  String get exercise_rowing => '划船';

  @override
  String get exercise_jump_rope => '跳绳';

  @override
  String get exercise_burpee => '波比跳';

  @override
  String get exercise_jumping_jack => '开合跳';

  @override
  String get exercise_clean => '上举';

  @override
  String get exercise_snatch => '抓举';

  @override
  String get exercise_thruster => '推举';

  @override
  String get exercise_box_jump => '箱跳';

  @override
  String get exercise_battle_rope => '战绳';

  @override
  String get supplement_vitamin_d3 => '维生素D3';

  @override
  String get supplement_vitamin_c => '维生素C';

  @override
  String get supplement_vitamin_b12 => '维生素B12';

  @override
  String get supplement_vitamin_a => '维生素A';

  @override
  String get supplement_vitamin_e => '维生素E';

  @override
  String get supplement_vitamin_k2 => '维生素K2';

  @override
  String get supplement_vitamin_b_complex => '复合维生素B';

  @override
  String get supplement_magnesium => '镁';

  @override
  String get supplement_zinc => '锌';

  @override
  String get supplement_iron => '铁';

  @override
  String get supplement_calcium => '钙';

  @override
  String get supplement_selenium => '硒';

  @override
  String get supplement_creatine => '肌酸';

  @override
  String get supplement_l_glutamine => 'L-谷氨酰胺';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-精氨酸';

  @override
  String get supplement_whey_protein => '乳清蛋白';

  @override
  String get supplement_casein => '酪蛋白';

  @override
  String get supplement_vegan_protein => '植物蛋白';

  @override
  String get supplement_omega3 => 'Omega-3';

  @override
  String get supplement_fish_oil => '鱼油';

  @override
  String get supplement_ashwagandha => '南非醉茄';

  @override
  String get supplement_rhodiola => '红景天';

  @override
  String get supplement_caffeine => '咖啡因';

  @override
  String get supplement_beta_alanine => 'β-丙氨酸';

  @override
  String get supplement_citrulline => '瓜氨酸';

  @override
  String get supplement_probiotics => '益生菌';

  @override
  String get supplement_prebiotics => '益生元';
}
