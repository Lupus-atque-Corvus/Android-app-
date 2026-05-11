// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String greetingMorning(String name) {
    return 'Bonjour, $name !';
  }

  @override
  String greetingDay(String name) {
    return 'Bon après-midi, $name !';
  }

  @override
  String greetingEvening(String name) {
    return 'Bonsoir, $name !';
  }

  @override
  String greetingNight(String name) {
    return 'Bonne nuit, $name !';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal pas';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal kcal';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal g protéines';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal ml';
  }

  @override
  String get homeBudgetAvailable => 'Solde disponible';

  @override
  String get homeNoAppointments => 'Aucun rendez-vous aujourd\'hui';

  @override
  String get homeNoGoal => 'Aucun objectif actif';

  @override
  String get homeTodayLabel => 'Aujourd\'hui';

  @override
  String homeHabitsStreak(int days) {
    return 'Série de $days jours';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'et $count de plus';
  }

  @override
  String get homeHealthSleep => 'Sommeil';

  @override
  String get homeHealthHeartRate => 'Fréquence cardiaque';

  @override
  String get homeHealthMood => 'Humeur';

  @override
  String get homeWaterAdd200 => '+200 ml';

  @override
  String get homeWaterAdd300 => '+300 ml';

  @override
  String get homeWaterAdd500 => '+500 ml';

  @override
  String get navHome => 'Accueil';

  @override
  String get navTraining => 'Entraînement';

  @override
  String get navHealth => 'Santé';

  @override
  String get navNutrition => 'Nutrition';

  @override
  String get navMore => 'Plus';

  @override
  String get navPlanning => 'Planning';

  @override
  String get navMedication => 'Médicaments';

  @override
  String get navSupplements => 'Suppléments';

  @override
  String get navAbstinence => 'Abstinence';

  @override
  String get navBudget => 'Budget';

  @override
  String get navPeriod => 'Cycle';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get trainingStart => 'Démarrer l\'entraînement';

  @override
  String get trainingHistory => 'Historique';

  @override
  String get trainingLastWorkout => 'Dernier entraînement';

  @override
  String get trainingActiveplan => 'Plan actif';

  @override
  String get trainingExerciseLibrary => 'Bibliothèque d\'exercices';

  @override
  String get trainingExerciseProgress => 'Progression';

  @override
  String get trainingVolume => 'Volume';

  @override
  String get trainingDuration => 'Durée';

  @override
  String trainingSetCount(int current, int total) {
    return 'Série $current sur $total';
  }

  @override
  String get trainingRestTimer => 'Repos';

  @override
  String get trainingWorkoutSummary => 'Entraînement terminé';

  @override
  String get trainingAddExercise => 'Ajouter un exercice';

  @override
  String get trainingCustomExercise => 'Exercice personnalisé';

  @override
  String get healthTitle => 'Santé';

  @override
  String get healthOverview => 'Aperçu';

  @override
  String get healthSleep => 'Sommeil';

  @override
  String get healthWeight => 'Poids';

  @override
  String get healthBodyMeasurements => 'Mesures corporelles';

  @override
  String get healthSteps7Days => 'Tendance 7 jours';

  @override
  String get healthSleepManual => 'Saisir manuellement';

  @override
  String get healthSleepQuality => 'Qualité du sommeil';

  @override
  String get healthWeightGoal => 'Poids cible';

  @override
  String get healthHeartRate => 'Fréquence cardiaque au repos';

  @override
  String get healthConnectPermission => 'Accès Health Connect';

  @override
  String get healthKitPermission => 'Accès Apple Health';

  @override
  String get healthNoData => 'Aucune donnée disponible';

  @override
  String get nutritionTitle => 'Nutrition';

  @override
  String get nutritionCalories => 'Calories';

  @override
  String get nutritionProtein => 'Protéines';

  @override
  String get nutritionCarbs => 'Glucides';

  @override
  String get nutritionFat => 'Graisses';

  @override
  String get nutritionWater => 'Eau';

  @override
  String get nutritionAddMeal => 'Ajouter un repas';

  @override
  String get nutritionSaveTemplate => 'Enregistrer comme modèle';

  @override
  String get nutritionShoppingList => 'Liste de courses';

  @override
  String get supplementTitle => 'Suppléments';

  @override
  String get supplementAdd => 'Ajouter un supplément';

  @override
  String get supplementTaken => 'Pris';

  @override
  String get supplementPending => 'En attente';

  @override
  String get supplementHistory => 'Historique';

  @override
  String get medicationTitle => 'Médicaments';

  @override
  String get medicationAdd => 'Ajouter un médicament';

  @override
  String get medicationTaken => 'Pris';

  @override
  String get medicationDose => 'Dose';

  @override
  String get medicationCompliance => 'Observance';

  @override
  String get abstinenceTitle => 'Abstinence';

  @override
  String get abstinenceAdd => 'Ajouter un suivi';

  @override
  String abstinenceDays(int days) {
    return '$days jours';
  }

  @override
  String get abstinenceRelapse => 'Rechute';

  @override
  String get abstinenceRelapseConfirm => 'Confirmer la rechute';

  @override
  String get abstinenceRelapseNote => 'Note (optionnel)';

  @override
  String get abstinenceLongestStreak => 'Plus longue série';

  @override
  String get abstinenceLastRelapse => 'Dernière rechute';

  @override
  String get budgetTitle => 'Budget';

  @override
  String get budgetAvailable => 'Solde disponible';

  @override
  String get budgetIncome => 'Revenus';

  @override
  String get budgetExpenses => 'Dépenses';

  @override
  String get budgetCategoryExpenses => 'Dépenses par catégorie';

  @override
  String get budgetVsLimit => 'Budget vs. dépenses';

  @override
  String budgetOverrun(String category) {
    return '$category dépassé !';
  }

  @override
  String get budgetAddTransaction => 'Ajouter une transaction';

  @override
  String get budgetSavings => 'Objectifs d\'épargne';

  @override
  String get budgetDebts => 'Dettes';

  @override
  String get periodTitle => 'Cycle';

  @override
  String periodDaysUntil(int days) {
    return 'Règles dans $days jours';
  }

  @override
  String get periodFertile => 'Fertile';

  @override
  String get periodNotFertile => 'Non fertile';

  @override
  String get periodOvulation => 'Ovulation';

  @override
  String get periodEnterPeriod => 'Saisir les règles';

  @override
  String get periodEnterSymptoms => 'Saisir les symptômes';

  @override
  String get periodPregnancyChance => 'Probabilité de grossesse';

  @override
  String get periodCalendar => 'Calendrier';

  @override
  String get periodMyCycles => 'Mes cycles';

  @override
  String get periodCycleTrends => 'Tendances';

  @override
  String get planningTitle => 'Planning';

  @override
  String get planningCalendar => 'Calendrier';

  @override
  String get planningTodos => 'Tâches';

  @override
  String get planningGoals => 'Objectifs';

  @override
  String get planningHabits => 'Habitudes';

  @override
  String get planningAddAppointment => 'Ajouter un rendez-vous';

  @override
  String get planningAddTodo => 'Ajouter une tâche';

  @override
  String get planningAddGoal => 'Ajouter un objectif';

  @override
  String get planningAddHabit => 'Ajouter une habitude';

  @override
  String get planningShowAll => 'Tout afficher';

  @override
  String get planningDueDate => 'Échéance';

  @override
  String get planningPriorityHigh => 'Haute';

  @override
  String get planningPriorityMedium => 'Moyenne';

  @override
  String get planningPriorityLow => 'Basse';

  @override
  String planningStreakDays(int days) {
    return '$days jours';
  }

  @override
  String planningLongestStreak(int days) {
    return 'Plus longue série : $days jours';
  }

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsUnits => 'Unités';

  @override
  String get settingsWeightUnit => 'Poids';

  @override
  String get settingsLengthUnit => 'Longueur';

  @override
  String get settingsTempUnit => 'Température';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsPrivacy => 'Confidentialité et sécurité';

  @override
  String get settingsPinBiometric => 'PIN / Biométrie';

  @override
  String get settingsExportData => 'Exporter les données';

  @override
  String get settingsBackup => 'Créer une sauvegarde';

  @override
  String get settingsRestore => 'Restaurer';

  @override
  String get settingsWeather => 'Météo';

  @override
  String get settingsNavigation => 'Personnaliser la navigation';

  @override
  String get settingsAccount => 'Compte et app';

  @override
  String get settingsPeriodTracking => 'Suivi du cycle';

  @override
  String get settingsResetOnboarding => 'Recommencer l\'introduction';

  @override
  String get settingsDeleteAllData => 'Supprimer toutes les données';

  @override
  String get settingsDeleteConfirmTitle => 'Supprimer toutes les données ?';

  @override
  String get settingsDeleteConfirmHint => 'Tapez SUPPRIMER pour confirmer';

  @override
  String get settingsWidgets => 'Widgets';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsVersion => 'Version';

  @override
  String get supportBugReport => 'Signaler un problème';

  @override
  String get supportEmailCopied => 'Email copié : support@traum-app.de';

  @override
  String get supportBugReportHint =>
      'Votre app email s\'ouvrira avec un brouillon.';

  @override
  String get onboardingWelcomeTitle => 'Bienvenue sur TRAUM';

  @override
  String get onboardingWelcomeSubtitle =>
      'Votre système personnel. Tout en un seul endroit.';

  @override
  String get onboardingProfileTitle => 'Votre profil';

  @override
  String get onboardingProfilePrivacyNote =>
      'Ces informations aident TRAUM à personnaliser l\'app. Toutes les données restent sur votre appareil.';

  @override
  String get onboardingNameLabel => 'Comment vous appeler ?';

  @override
  String get onboardingNameHint => 'Votre prénom';

  @override
  String get onboardingBirthday => 'Date de naissance (optionnel)';

  @override
  String get onboardingBiologicalSex => 'Sexe biologique';

  @override
  String get onboardingSexMale => 'Masculin';

  @override
  String get onboardingSexFemale => 'Féminin';

  @override
  String get onboardingSexNone => 'Ne pas préciser';

  @override
  String get onboardingPeriodActivated =>
      'Le suivi du cycle sera activé pour vous.';

  @override
  String get onboardingUnits => 'Unités';

  @override
  String get onboardingFitnessTitle => 'Forme et santé';

  @override
  String get onboardingStepsGoal => 'Objectif de pas quotidien';

  @override
  String get onboardingCurrentWeight => 'Poids actuel';

  @override
  String get onboardingTargetWeight => 'Poids cible';

  @override
  String get onboardingHeight => 'Taille';

  @override
  String get onboardingNutritionTitle => 'Nutrition';

  @override
  String get onboardingCalorieGoal => 'Objectif calorique quotidien';

  @override
  String get onboardingProteinGoal => 'Objectif de protéines (g)';

  @override
  String get onboardingWaterGoal => 'Objectif d\'eau (ml)';

  @override
  String get onboardingNutritionHint =>
      'Vous pouvez ajuster ces valeurs dans les paramètres à tout moment.';

  @override
  String get onboardingPeriodTitle => 'Votre cycle';

  @override
  String get onboardingPeriodSubtitle =>
      'TRAUM calcule votre cycle et vous donne des informations pertinentes — sans cloud, sans partage.';

  @override
  String get onboardingLastPeriodStart => 'Premier jour des dernières règles';

  @override
  String get onboardingCycleLength => 'Durée moyenne du cycle';

  @override
  String get onboardingPeriodLength => 'Durée moyenne des règles';

  @override
  String get onboardingPeriodSetup => 'Configurer';

  @override
  String get onboardingPeriodLater => 'Configurer plus tard';

  @override
  String get onboardingNavTitle => 'Votre navigation';

  @override
  String get onboardingNavSubtitle =>
      'Choisissez quels modules apparaissent dans votre barre de navigation.';

  @override
  String get onboardingHealthTitle => 'Données de santé';

  @override
  String get onboardingHealthAndroid =>
      'TRAUM peut lire automatiquement les pas, le sommeil et la fréquence cardiaque depuis Health Connect.';

  @override
  String get onboardingHealthIOS =>
      'TRAUM peut lire automatiquement les pas, le sommeil et la fréquence cardiaque depuis Apple Health.';

  @override
  String get onboardingHealthAllow => 'Autoriser l\'accès';

  @override
  String get onboardingHealthSkip => 'Plus tard';

  @override
  String get onboardingNotifTitle => 'Notifications';

  @override
  String get onboardingNotifSubtitle =>
      'Rappels pour médicaments, eau et tâches.';

  @override
  String get onboardingNotifAllow => 'Activer les notifications';

  @override
  String get onboardingNotifSkip => 'Non merci';

  @override
  String get onboardingDoneTitle => 'Tout est prêt.';

  @override
  String get onboardingDoneSubtitle =>
      'Votre système vous attend. Vous pouvez ajuster tous les paramètres à tout moment.';

  @override
  String get onboardingDoneHint =>
      'Vos données ne quittent jamais cet appareil.';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingFinish => 'C\'est parti !';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonShowAll => 'Tout afficher';

  @override
  String get commonNoData => 'Aucune donnée';

  @override
  String get commonLoading => 'Chargement…';

  @override
  String get commonError => 'Erreur';

  @override
  String get commonSuccess => 'Enregistré avec succès';

  @override
  String commonDays(int count) {
    return '$count jours';
  }

  @override
  String commonHours(int count) {
    return '$count heures';
  }

  @override
  String commonMinutes(int count) {
    return '$count minutes';
  }

  @override
  String get notifMedication => 'Médicaments';

  @override
  String get notifSupplement => 'Suppléments';

  @override
  String get notifWorkout => 'Entraînement';

  @override
  String get notifWater => 'Eau';

  @override
  String get notifTodo => 'Tâches';

  @override
  String get notifHabit => 'Habitudes';

  @override
  String get notifCalendar => 'Calendrier';

  @override
  String get notifHealth => 'Santé';

  @override
  String get notifBudget => 'Budget';

  @override
  String get notifPeriod => 'Cycle';

  @override
  String get exercise_bench_press => 'Développé couché (barre)';

  @override
  String get exercise_push_up => 'Pompes';

  @override
  String get exercise_pull_up => 'Tractions';

  @override
  String get exercise_squat => 'Squat';

  @override
  String get exercise_deadlift => 'Soulevé de terre';

  @override
  String get exercise_shoulder_press => 'Développé épaules';

  @override
  String get exercise_bicep_curl => 'Curl biceps';

  @override
  String get exercise_tricep_dip => 'Dips triceps';

  @override
  String get exercise_plank => 'Gainage';

  @override
  String get exercise_running => 'Course';

  @override
  String get exercise_incline_press => 'Développé incliné';

  @override
  String get exercise_chest_fly => 'Écarté couché';

  @override
  String get exercise_cable_crossover => 'Croisé poulies';

  @override
  String get exercise_dip => 'Dips';

  @override
  String get exercise_lat_pulldown => 'Tirage vertical';

  @override
  String get exercise_bent_row => 'Rowing barre';

  @override
  String get exercise_seated_row => 'Rowing assis';

  @override
  String get exercise_pullover => 'Pullover';

  @override
  String get exercise_face_pull => 'Face pull';

  @override
  String get exercise_lateral_raise => 'Élévations latérales';

  @override
  String get exercise_front_raise => 'Élévations frontales';

  @override
  String get exercise_rear_delt_fly => 'Écarté oiseau';

  @override
  String get exercise_hammer_curl => 'Curl marteau';

  @override
  String get exercise_concentration_curl => 'Curl concentré';

  @override
  String get exercise_skull_crusher => 'Barre au front';

  @override
  String get exercise_overhead_tricep => 'Extension triceps';

  @override
  String get exercise_leg_press => 'Presse à jambes';

  @override
  String get exercise_leg_curl => 'Curl jambes';

  @override
  String get exercise_leg_extension => 'Extension jambes';

  @override
  String get exercise_calf_raise => 'Mollets debout';

  @override
  String get exercise_lunge => 'Fente';

  @override
  String get exercise_glute_bridge => 'Pont fessier';

  @override
  String get exercise_crunch => 'Crunch';

  @override
  String get exercise_russian_twist => 'Twist russe';

  @override
  String get exercise_leg_raise => 'Relevé de jambes';

  @override
  String get exercise_mountain_climber => 'Grimpeur';

  @override
  String get exercise_bicycle_crunch => 'Crunch vélo';

  @override
  String get exercise_cycling => 'Vélo';

  @override
  String get exercise_rowing => 'Aviron';

  @override
  String get exercise_jump_rope => 'Corde à sauter';

  @override
  String get exercise_burpee => 'Burpee';

  @override
  String get exercise_jumping_jack => 'Jumping jack';

  @override
  String get exercise_clean => 'Épaulé';

  @override
  String get exercise_snatch => 'Arraché';

  @override
  String get exercise_thruster => 'Thruster';

  @override
  String get exercise_box_jump => 'Saut sur boîte';

  @override
  String get exercise_battle_rope => 'Corde battle';

  @override
  String get supplement_vitamin_d3 => 'Vitamine D3';

  @override
  String get supplement_vitamin_c => 'Vitamine C';

  @override
  String get supplement_vitamin_b12 => 'Vitamine B12';

  @override
  String get supplement_vitamin_a => 'Vitamine A';

  @override
  String get supplement_vitamin_e => 'Vitamine E';

  @override
  String get supplement_vitamin_k2 => 'Vitamine K2';

  @override
  String get supplement_vitamin_b_complex => 'Complexe vitamine B';

  @override
  String get supplement_magnesium => 'Magnésium';

  @override
  String get supplement_zinc => 'Zinc';

  @override
  String get supplement_iron => 'Fer';

  @override
  String get supplement_calcium => 'Calcium';

  @override
  String get supplement_selenium => 'Sélénium';

  @override
  String get supplement_creatine => 'Créatine';

  @override
  String get supplement_l_glutamine => 'L-Glutamine';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-Arginine';

  @override
  String get supplement_whey_protein => 'Protéine de lactosérum';

  @override
  String get supplement_casein => 'Caséine';

  @override
  String get supplement_vegan_protein => 'Protéine végane';

  @override
  String get supplement_omega3 => 'Oméga-3';

  @override
  String get supplement_fish_oil => 'Huile de poisson';

  @override
  String get supplement_ashwagandha => 'Ashwagandha';

  @override
  String get supplement_rhodiola => 'Rhodiola';

  @override
  String get supplement_caffeine => 'Caféine';

  @override
  String get supplement_beta_alanine => 'Bêta-alanine';

  @override
  String get supplement_citrulline => 'Citrulline';

  @override
  String get supplement_probiotics => 'Probiotiques';

  @override
  String get supplement_prebiotics => 'Prébiotiques';

  @override
  String get weatherClear => 'Clair';

  @override
  String get weatherMostlyClear => 'Principalement clair';

  @override
  String get weatherPartlyCloudy => 'Partiellement nuageux';

  @override
  String get weatherOvercast => 'Couvert';

  @override
  String get weatherFoggy => 'Brumeux';

  @override
  String get weatherDrizzle => 'Bruine';

  @override
  String get weatherRain => 'Pluie';

  @override
  String get weatherSnowfall => 'Chutes de neige';

  @override
  String get weatherSnowGrains => 'Grains de neige';

  @override
  String get weatherRainShowers => 'Averses';

  @override
  String get weatherSnowShowers => 'Averses de neige';

  @override
  String get weatherThunderstorm => 'Orage';

  @override
  String get weatherHeavyThunderstorm => 'Orage violent';
}
