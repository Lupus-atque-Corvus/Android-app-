// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String greetingMorning(String name) {
    return 'Guten Morgen, $name!';
  }

  @override
  String greetingDay(String name) {
    return 'Guten Tag, $name!';
  }

  @override
  String greetingEvening(String name) {
    return 'Guten Abend, $name!';
  }

  @override
  String greetingNight(String name) {
    return 'Gute Nacht, $name!';
  }

  @override
  String homeStepsGoal(int current, int goal) {
    return '$current / $goal Schritte';
  }

  @override
  String homeCaloriesGoal(int current, int goal) {
    return '$current / $goal kcal';
  }

  @override
  String homeProteinGoal(int current, int goal) {
    return '$current / $goal g Protein';
  }

  @override
  String homeWaterGoal(int current, int goal) {
    return '$current / $goal ml';
  }

  @override
  String get homeBudgetAvailable => 'Verfügbares Guthaben';

  @override
  String get homeNoAppointments => 'Keine Termine heute';

  @override
  String get homeNoGoal => 'Kein aktives Ziel';

  @override
  String get homeTodayLabel => 'Heute';

  @override
  String homeHabitsStreak(int days) {
    return '$days Tage Streak';
  }

  @override
  String homeAbstinenceMore(int count) {
    return 'und $count weitere';
  }

  @override
  String get homeHealthSleep => 'Schlaf';

  @override
  String get homeHealthHeartRate => 'Herzfrequenz';

  @override
  String get homeHealthMood => 'Stimmung';

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
  String get navHealth => 'Gesundheit';

  @override
  String get navNutrition => 'Ernährung';

  @override
  String get navMore => 'Mehr';

  @override
  String get navPlanning => 'Planung';

  @override
  String get navMedication => 'Medikamente';

  @override
  String get navSupplements => 'Supplemente';

  @override
  String get navAbstinence => 'Abstinenz';

  @override
  String get navBudget => 'Budget';

  @override
  String get navPeriod => 'Zyklus';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get trainingStart => 'Workout starten';

  @override
  String get trainingHistory => 'Trainingshistorie';

  @override
  String get trainingLastWorkout => 'Letztes Workout';

  @override
  String get trainingActiveplan => 'Aktiver Plan';

  @override
  String get trainingExerciseLibrary => 'Übungsbibliothek';

  @override
  String get trainingExerciseProgress => 'Übungsfortschritt';

  @override
  String get trainingVolume => 'Volumen';

  @override
  String get trainingDuration => 'Dauer';

  @override
  String trainingSetCount(int current, int total) {
    return 'Satz $current von $total';
  }

  @override
  String get trainingRestTimer => 'Pause';

  @override
  String get trainingWorkoutSummary => 'Workout abgeschlossen';

  @override
  String get trainingAddExercise => 'Übung hinzufügen';

  @override
  String get trainingCustomExercise => 'Eigene Übung';

  @override
  String get healthTitle => 'Gesundheit';

  @override
  String get healthOverview => 'Übersicht';

  @override
  String get healthSleep => 'Schlaf';

  @override
  String get healthWeight => 'Gewicht';

  @override
  String get healthBodyMeasurements => 'Körpermaße';

  @override
  String get healthSteps7Days => '7-Tage-Verlauf';

  @override
  String get healthSleepManual => 'Manuell eingeben';

  @override
  String get healthSleepQuality => 'Schlafqualität';

  @override
  String get healthWeightGoal => 'Zielgewicht';

  @override
  String get healthHeartRate => 'Herzfrequenz (Ruhend)';

  @override
  String get healthConnectPermission => 'Health Connect Zugriff';

  @override
  String get healthKitPermission => 'Apple Health Zugriff';

  @override
  String get healthNoData => 'Keine Daten vorhanden';

  @override
  String get nutritionTitle => 'Ernährung';

  @override
  String get nutritionCalories => 'Kalorien';

  @override
  String get nutritionProtein => 'Protein';

  @override
  String get nutritionCarbs => 'Kohlenhydrate';

  @override
  String get nutritionFat => 'Fett';

  @override
  String get nutritionWater => 'Wasser';

  @override
  String get nutritionAddMeal => 'Mahlzeit hinzufügen';

  @override
  String get nutritionSaveTemplate => 'Als Vorlage speichern';

  @override
  String get nutritionShoppingList => 'Einkaufsliste';

  @override
  String get supplementTitle => 'Supplemente';

  @override
  String get supplementAdd => 'Supplement hinzufügen';

  @override
  String get supplementTaken => 'Eingenommen';

  @override
  String get supplementPending => 'Noch ausstehend';

  @override
  String get supplementHistory => 'Verlauf';

  @override
  String get medicationTitle => 'Medikamente';

  @override
  String get medicationAdd => 'Medikament hinzufügen';

  @override
  String get medicationTaken => 'Eingenommen';

  @override
  String get medicationDose => 'Dosis';

  @override
  String get medicationCompliance => 'Einnahmetreue';

  @override
  String get abstinenceTitle => 'Abstinenz';

  @override
  String get abstinenceAdd => 'Tracker hinzufügen';

  @override
  String abstinenceDays(int days) {
    return '$days Tage';
  }

  @override
  String get abstinenceRelapse => 'Rückfall';

  @override
  String get abstinenceRelapseConfirm => 'Rückfall bestätigen';

  @override
  String get abstinenceRelapseNote => 'Notiz (optional)';

  @override
  String get abstinenceLongestStreak => 'Längste Streak';

  @override
  String get abstinenceLastRelapse => 'Letzter Vorfall';

  @override
  String get budgetTitle => 'Budget';

  @override
  String get budgetAvailable => 'Verfügbares Guthaben';

  @override
  String get budgetIncome => 'Einnahmen';

  @override
  String get budgetExpenses => 'Ausgaben';

  @override
  String get budgetCategoryExpenses => 'Ausgaben nach Kategorie';

  @override
  String get budgetVsLimit => 'Budget vs. Ausgaben';

  @override
  String budgetOverrun(String category) {
    return '$category überschritten!';
  }

  @override
  String get budgetAddTransaction => 'Transaktion hinzufügen';

  @override
  String get budgetSavings => 'Sparziele';

  @override
  String get budgetDebts => 'Schulden';

  @override
  String get periodTitle => 'Zyklus';

  @override
  String periodDaysUntil(int days) {
    return 'Periode in $days Tagen';
  }

  @override
  String get periodFertile => 'Fruchtbar';

  @override
  String get periodNotFertile => 'Nicht fruchtbar';

  @override
  String get periodOvulation => 'Eisprung';

  @override
  String get periodEnterPeriod => 'Periode eingeben';

  @override
  String get periodEnterSymptoms => 'Symptome eingeben';

  @override
  String get periodPregnancyChance => 'Schwangerschaftswahrscheinlichkeit';

  @override
  String get periodCalendar => 'Kalender';

  @override
  String get periodMyCycles => 'Meine Zyklen';

  @override
  String get periodCycleTrends => 'Zyklustrends';

  @override
  String get planningTitle => 'Planung';

  @override
  String get planningCalendar => 'Kalender';

  @override
  String get planningTodos => 'Aufgaben';

  @override
  String get planningGoals => 'Ziele';

  @override
  String get planningHabits => 'Gewohnheiten';

  @override
  String get planningAddAppointment => 'Termin hinzufügen';

  @override
  String get planningAddTodo => 'Aufgabe hinzufügen';

  @override
  String get planningAddGoal => 'Ziel hinzufügen';

  @override
  String get planningAddHabit => 'Gewohnheit hinzufügen';

  @override
  String get planningShowAll => 'Alle anzeigen';

  @override
  String get planningDueDate => 'Fällig';

  @override
  String get planningPriorityHigh => 'Hoch';

  @override
  String get planningPriorityMedium => 'Mittel';

  @override
  String get planningPriorityLow => 'Niedrig';

  @override
  String planningStreakDays(int days) {
    return '$days Tage';
  }

  @override
  String planningLongestStreak(int days) {
    return 'Längste Serie: $days Tage';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsAppearance => 'Erscheinungsbild';

  @override
  String get settingsTheme => 'App-Theme';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsUnits => 'Einheiten';

  @override
  String get settingsWeightUnit => 'Gewicht';

  @override
  String get settingsLengthUnit => 'Länge';

  @override
  String get settingsTempUnit => 'Temperatur';

  @override
  String get settingsNotifications => 'Benachrichtigungen';

  @override
  String get settingsPrivacy => 'Datenschutz & Sicherheit';

  @override
  String get settingsPinBiometric => 'PIN / Biometrie';

  @override
  String get settingsExportData => 'Daten exportieren';

  @override
  String get settingsBackup => 'Backup erstellen';

  @override
  String get settingsRestore => 'Backup wiederherstellen';

  @override
  String get settingsWeather => 'Wetter';

  @override
  String get settingsNavigation => 'Navigation anpassen';

  @override
  String get settingsAccount => 'Konto & App';

  @override
  String get settingsPeriodTracking => 'Periodentracking';

  @override
  String get settingsResetOnboarding => 'Onboarding wiederholen';

  @override
  String get settingsDeleteAllData => 'Alle Daten löschen';

  @override
  String get settingsDeleteConfirmTitle => 'Wirklich alle Daten löschen?';

  @override
  String get settingsDeleteConfirmHint => 'Tippe LÖSCHEN zur Bestätigung';

  @override
  String get settingsWidgets => 'Widgets';

  @override
  String get settingsSupport => 'Support & Feedback';

  @override
  String get settingsVersion => 'App-Version';

  @override
  String get supportBugReport => 'Fehler melden';

  @override
  String get supportEmailCopied =>
      'E-Mail-Adresse kopiert: support@traum-app.de';

  @override
  String get supportBugReportHint =>
      'Deine E-Mail-App öffnet sich mit einem vorausgefüllten Entwurf.';

  @override
  String get onboardingWelcomeTitle => 'Willkommen bei TRAUM';

  @override
  String get onboardingWelcomeSubtitle =>
      'Dein persönliches System. Alles an einem Ort. 100% auf deinem Gerät.';

  @override
  String get onboardingProfileTitle => 'Dein Profil';

  @override
  String get onboardingProfilePrivacyNote =>
      'Die folgenden Angaben helfen TRAUM, die App individuell auf dich einzustellen. Alle Daten bleiben lokal auf deinem Gerät.';

  @override
  String get onboardingNameLabel => 'Wie sollen wir dich nennen?';

  @override
  String get onboardingNameHint => 'Dein Name';

  @override
  String get onboardingBirthday => 'Geburtstag (optional)';

  @override
  String get onboardingBiologicalSex => 'Biologisches Geschlecht';

  @override
  String get onboardingSexMale => 'Männlich';

  @override
  String get onboardingSexFemale => 'Weiblich';

  @override
  String get onboardingSexNone => 'Keine Angabe';

  @override
  String get onboardingPeriodActivated =>
      'Periodentracking wird für dich aktiviert.';

  @override
  String get onboardingUnits => 'Einheiten';

  @override
  String get onboardingFitnessTitle => 'Fitness & Gesundheit';

  @override
  String get onboardingStepsGoal => 'Schritte-Tagesziel';

  @override
  String get onboardingCurrentWeight => 'Aktuelles Gewicht';

  @override
  String get onboardingTargetWeight => 'Zielgewicht';

  @override
  String get onboardingHeight => 'Körpergröße';

  @override
  String get onboardingNutritionTitle => 'Ernährung';

  @override
  String get onboardingCalorieGoal => 'Kalorienziel täglich';

  @override
  String get onboardingProteinGoal => 'Proteinziel täglich (g)';

  @override
  String get onboardingWaterGoal => 'Wasserziel täglich (ml)';

  @override
  String get onboardingNutritionHint =>
      'Diese Werte kannst du jederzeit in den Einstellungen anpassen.';

  @override
  String get onboardingPeriodTitle => 'Dein Zyklus';

  @override
  String get onboardingPeriodSubtitle =>
      'TRAUM berechnet deinen Zyklus, fruchtbare Tage und gibt dir täglich relevante Informationen — ohne Cloud, ohne Datenweitergabe.';

  @override
  String get onboardingLastPeriodStart => 'Erster Tag der letzten Periode';

  @override
  String get onboardingCycleLength => 'Durchschnittliche Zykluslänge';

  @override
  String get onboardingPeriodLength => 'Durchschnittliche Periodenlänge';

  @override
  String get onboardingPeriodSetup => 'Einrichten';

  @override
  String get onboardingPeriodLater => 'Später einrichten';

  @override
  String get onboardingNavTitle => 'Deine Navigation';

  @override
  String get onboardingNavSubtitle =>
      'Wähle, welche Module in deiner Leiste erscheinen sollen.';

  @override
  String get onboardingHealthTitle => 'Gesundheitsdaten';

  @override
  String get onboardingHealthAndroid =>
      'TRAUM kann Schritte, Schlaf und Herzfrequenz automatisch aus Health Connect lesen.';

  @override
  String get onboardingHealthIOS =>
      'TRAUM kann Schritte, Schlaf und Herzfrequenz automatisch aus Apple Health lesen.';

  @override
  String get onboardingHealthAllow => 'Zugriff erlauben';

  @override
  String get onboardingHealthSkip => 'Später';

  @override
  String get onboardingNotifTitle => 'Benachrichtigungen';

  @override
  String get onboardingNotifSubtitle =>
      'Erinnerungen für Medikamente, Wasser und Aufgaben.';

  @override
  String get onboardingNotifAllow => 'Benachrichtigungen aktivieren';

  @override
  String get onboardingNotifSkip => 'Nein danke';

  @override
  String get onboardingDoneTitle => 'Alles bereit.';

  @override
  String get onboardingDoneSubtitle =>
      'Dein System wartet. Du kannst alle Einstellungen jederzeit anpassen.';

  @override
  String get onboardingDoneHint => 'Deine Daten verlassen nie dieses Gerät.';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingFinish => 'Los geht\'s';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String get commonConfirm => 'Bestätigen';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonShowAll => 'Alle anzeigen';

  @override
  String get commonNoData => 'Keine Daten';

  @override
  String get commonLoading => 'Wird geladen…';

  @override
  String get commonError => 'Fehler aufgetreten';

  @override
  String get commonSuccess => 'Erfolgreich gespeichert';

  @override
  String commonDays(int count) {
    return '$count Tage';
  }

  @override
  String commonHours(int count) {
    return '$count Stunden';
  }

  @override
  String commonMinutes(int count) {
    return '$count Minuten';
  }

  @override
  String get notifMedication => 'Medikamente';

  @override
  String get notifSupplement => 'Supplemente';

  @override
  String get notifWorkout => 'Training';

  @override
  String get notifWater => 'Wasser';

  @override
  String get notifTodo => 'Aufgaben';

  @override
  String get notifHabit => 'Gewohnheiten';

  @override
  String get notifCalendar => 'Kalender';

  @override
  String get notifHealth => 'Gesundheit';

  @override
  String get notifBudget => 'Budget';

  @override
  String get notifPeriod => 'Zyklus';

  @override
  String get exercise_bench_press => 'Bankdrücken (Langhantel)';

  @override
  String get exercise_push_up => 'Liegestütz';

  @override
  String get exercise_pull_up => 'Klimmzug';

  @override
  String get exercise_squat => 'Kniebeuge';

  @override
  String get exercise_deadlift => 'Kreuzheben';

  @override
  String get exercise_shoulder_press => 'Schulterdrücken';

  @override
  String get exercise_bicep_curl => 'Bizepscurl';

  @override
  String get exercise_tricep_dip => 'Trizepsdrücken';

  @override
  String get exercise_plank => 'Plank';

  @override
  String get exercise_running => 'Laufen';

  @override
  String get exercise_incline_press => 'Schrägbankdrücken';

  @override
  String get exercise_chest_fly => 'Fliegende Brust';

  @override
  String get exercise_cable_crossover => 'Kabelzug Kreuzung';

  @override
  String get exercise_dip => 'Dip';

  @override
  String get exercise_lat_pulldown => 'Latzug';

  @override
  String get exercise_bent_row => 'Rudern vorgebeugt';

  @override
  String get exercise_seated_row => 'Rudern sitzend';

  @override
  String get exercise_pullover => 'Pullover';

  @override
  String get exercise_face_pull => 'Face Pull';

  @override
  String get exercise_lateral_raise => 'Seitheben';

  @override
  String get exercise_front_raise => 'Vorwaärtsheben';

  @override
  String get exercise_rear_delt_fly => 'Hinteres Deltaheben';

  @override
  String get exercise_hammer_curl => 'Hammer Curl';

  @override
  String get exercise_concentration_curl => 'Konzentrations Curl';

  @override
  String get exercise_skull_crusher => 'Skull Crusher';

  @override
  String get exercise_overhead_tricep => 'Trizeps über Kopf';

  @override
  String get exercise_leg_press => 'Beinpresse';

  @override
  String get exercise_leg_curl => 'Beinbeuger';

  @override
  String get exercise_leg_extension => 'Beinstrecker';

  @override
  String get exercise_calf_raise => 'Wadenheben';

  @override
  String get exercise_lunge => 'Ausfallschritt';

  @override
  String get exercise_glute_bridge => 'Gesäßbrücke';

  @override
  String get exercise_crunch => 'Crunch';

  @override
  String get exercise_russian_twist => 'Russian Twist';

  @override
  String get exercise_leg_raise => 'Beinheben';

  @override
  String get exercise_mountain_climber => 'Mountain Climber';

  @override
  String get exercise_bicycle_crunch => 'Fahrradsitz';

  @override
  String get exercise_cycling => 'Radfahren';

  @override
  String get exercise_rowing => 'Rudern';

  @override
  String get exercise_jump_rope => 'Seilspringen';

  @override
  String get exercise_burpee => 'Burpee';

  @override
  String get exercise_jumping_jack => 'Hampelmann';

  @override
  String get exercise_clean => 'Clean';

  @override
  String get exercise_snatch => 'Reißen';

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
  String get supplement_vitamin_b_complex => 'Vitamin B-Komplex';

  @override
  String get supplement_magnesium => 'Magnesium';

  @override
  String get supplement_zinc => 'Zink';

  @override
  String get supplement_iron => 'Eisen';

  @override
  String get supplement_calcium => 'Calcium';

  @override
  String get supplement_selenium => 'Selen';

  @override
  String get supplement_creatine => 'Kreatin';

  @override
  String get supplement_l_glutamine => 'L-Glutamin';

  @override
  String get supplement_bcaa => 'BCAA';

  @override
  String get supplement_l_arginine => 'L-Arginin';

  @override
  String get supplement_whey_protein => 'Whey Protein';

  @override
  String get supplement_casein => 'Casein Protein';

  @override
  String get supplement_vegan_protein => 'Veganes Protein';

  @override
  String get supplement_omega3 => 'Omega-3';

  @override
  String get supplement_fish_oil => 'Fischöl';

  @override
  String get supplement_ashwagandha => 'Ashwagandha';

  @override
  String get supplement_rhodiola => 'Rhodiola';

  @override
  String get supplement_caffeine => 'Koffein';

  @override
  String get supplement_beta_alanine => 'Beta-Alanin';

  @override
  String get supplement_citrulline => 'Citrullin';

  @override
  String get supplement_probiotics => 'Probiotika';

  @override
  String get supplement_prebiotics => 'Präbiotika';
}
