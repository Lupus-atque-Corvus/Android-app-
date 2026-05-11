import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('de'),
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @greetingMorning.
  ///
  /// In de, this message translates to:
  /// **'Guten Morgen, {name}!'**
  String greetingMorning(String name);

  /// No description provided for @greetingDay.
  ///
  /// In de, this message translates to:
  /// **'Guten Tag, {name}!'**
  String greetingDay(String name);

  /// No description provided for @greetingEvening.
  ///
  /// In de, this message translates to:
  /// **'Guten Abend, {name}!'**
  String greetingEvening(String name);

  /// No description provided for @greetingNight.
  ///
  /// In de, this message translates to:
  /// **'Gute Nacht, {name}!'**
  String greetingNight(String name);

  /// No description provided for @homeStepsGoal.
  ///
  /// In de, this message translates to:
  /// **'{current} / {goal} Schritte'**
  String homeStepsGoal(int current, int goal);

  /// No description provided for @homeCaloriesGoal.
  ///
  /// In de, this message translates to:
  /// **'{current} / {goal} kcal'**
  String homeCaloriesGoal(int current, int goal);

  /// No description provided for @homeProteinGoal.
  ///
  /// In de, this message translates to:
  /// **'{current} / {goal} g Protein'**
  String homeProteinGoal(int current, int goal);

  /// No description provided for @homeWaterGoal.
  ///
  /// In de, this message translates to:
  /// **'{current} / {goal} ml'**
  String homeWaterGoal(int current, int goal);

  /// No description provided for @homeBudgetAvailable.
  ///
  /// In de, this message translates to:
  /// **'Verfügbares Guthaben'**
  String get homeBudgetAvailable;

  /// No description provided for @homeNoAppointments.
  ///
  /// In de, this message translates to:
  /// **'Keine Termine heute'**
  String get homeNoAppointments;

  /// No description provided for @homeNoGoal.
  ///
  /// In de, this message translates to:
  /// **'Kein aktives Ziel'**
  String get homeNoGoal;

  /// No description provided for @homeTodayLabel.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get homeTodayLabel;

  /// No description provided for @homeHabitsStreak.
  ///
  /// In de, this message translates to:
  /// **'{days} Tage Streak'**
  String homeHabitsStreak(int days);

  /// No description provided for @homeAbstinenceMore.
  ///
  /// In de, this message translates to:
  /// **'und {count} weitere'**
  String homeAbstinenceMore(int count);

  /// No description provided for @homeHealthSleep.
  ///
  /// In de, this message translates to:
  /// **'Schlaf'**
  String get homeHealthSleep;

  /// No description provided for @homeHealthHeartRate.
  ///
  /// In de, this message translates to:
  /// **'Herzfrequenz'**
  String get homeHealthHeartRate;

  /// No description provided for @homeHealthMood.
  ///
  /// In de, this message translates to:
  /// **'Stimmung'**
  String get homeHealthMood;

  /// No description provided for @homeWaterAdd200.
  ///
  /// In de, this message translates to:
  /// **'+200 ml'**
  String get homeWaterAdd200;

  /// No description provided for @homeWaterAdd300.
  ///
  /// In de, this message translates to:
  /// **'+300 ml'**
  String get homeWaterAdd300;

  /// No description provided for @homeWaterAdd500.
  ///
  /// In de, this message translates to:
  /// **'+500 ml'**
  String get homeWaterAdd500;

  /// No description provided for @navHome.
  ///
  /// In de, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTraining.
  ///
  /// In de, this message translates to:
  /// **'Training'**
  String get navTraining;

  /// No description provided for @navHealth.
  ///
  /// In de, this message translates to:
  /// **'Gesundheit'**
  String get navHealth;

  /// No description provided for @navNutrition.
  ///
  /// In de, this message translates to:
  /// **'Ernährung'**
  String get navNutrition;

  /// No description provided for @navMore.
  ///
  /// In de, this message translates to:
  /// **'Mehr'**
  String get navMore;

  /// No description provided for @navPlanning.
  ///
  /// In de, this message translates to:
  /// **'Planung'**
  String get navPlanning;

  /// No description provided for @navMedication.
  ///
  /// In de, this message translates to:
  /// **'Medikamente'**
  String get navMedication;

  /// No description provided for @navSupplements.
  ///
  /// In de, this message translates to:
  /// **'Supplemente'**
  String get navSupplements;

  /// No description provided for @navAbstinence.
  ///
  /// In de, this message translates to:
  /// **'Abstinenz'**
  String get navAbstinence;

  /// No description provided for @navBudget.
  ///
  /// In de, this message translates to:
  /// **'Budget'**
  String get navBudget;

  /// No description provided for @navPeriod.
  ///
  /// In de, this message translates to:
  /// **'Zyklus'**
  String get navPeriod;

  /// No description provided for @navSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get navSettings;

  /// No description provided for @trainingStart.
  ///
  /// In de, this message translates to:
  /// **'Workout starten'**
  String get trainingStart;

  /// No description provided for @trainingHistory.
  ///
  /// In de, this message translates to:
  /// **'Trainingshistorie'**
  String get trainingHistory;

  /// No description provided for @trainingLastWorkout.
  ///
  /// In de, this message translates to:
  /// **'Letztes Workout'**
  String get trainingLastWorkout;

  /// No description provided for @trainingActiveplan.
  ///
  /// In de, this message translates to:
  /// **'Aktiver Plan'**
  String get trainingActiveplan;

  /// No description provided for @trainingExerciseLibrary.
  ///
  /// In de, this message translates to:
  /// **'Übungsbibliothek'**
  String get trainingExerciseLibrary;

  /// No description provided for @trainingExerciseProgress.
  ///
  /// In de, this message translates to:
  /// **'Übungsfortschritt'**
  String get trainingExerciseProgress;

  /// No description provided for @trainingVolume.
  ///
  /// In de, this message translates to:
  /// **'Volumen'**
  String get trainingVolume;

  /// No description provided for @trainingDuration.
  ///
  /// In de, this message translates to:
  /// **'Dauer'**
  String get trainingDuration;

  /// No description provided for @trainingSetCount.
  ///
  /// In de, this message translates to:
  /// **'Satz {current} von {total}'**
  String trainingSetCount(int current, int total);

  /// No description provided for @trainingRestTimer.
  ///
  /// In de, this message translates to:
  /// **'Pause'**
  String get trainingRestTimer;

  /// No description provided for @trainingWorkoutSummary.
  ///
  /// In de, this message translates to:
  /// **'Workout abgeschlossen'**
  String get trainingWorkoutSummary;

  /// No description provided for @trainingAddExercise.
  ///
  /// In de, this message translates to:
  /// **'Übung hinzufügen'**
  String get trainingAddExercise;

  /// No description provided for @trainingCustomExercise.
  ///
  /// In de, this message translates to:
  /// **'Eigene Übung'**
  String get trainingCustomExercise;

  /// No description provided for @healthTitle.
  ///
  /// In de, this message translates to:
  /// **'Gesundheit'**
  String get healthTitle;

  /// No description provided for @healthOverview.
  ///
  /// In de, this message translates to:
  /// **'Übersicht'**
  String get healthOverview;

  /// No description provided for @healthSleep.
  ///
  /// In de, this message translates to:
  /// **'Schlaf'**
  String get healthSleep;

  /// No description provided for @healthWeight.
  ///
  /// In de, this message translates to:
  /// **'Gewicht'**
  String get healthWeight;

  /// No description provided for @healthBodyMeasurements.
  ///
  /// In de, this message translates to:
  /// **'Körpermaße'**
  String get healthBodyMeasurements;

  /// No description provided for @healthSteps7Days.
  ///
  /// In de, this message translates to:
  /// **'7-Tage-Verlauf'**
  String get healthSteps7Days;

  /// No description provided for @healthSleepManual.
  ///
  /// In de, this message translates to:
  /// **'Manuell eingeben'**
  String get healthSleepManual;

  /// No description provided for @healthSleepQuality.
  ///
  /// In de, this message translates to:
  /// **'Schlafqualität'**
  String get healthSleepQuality;

  /// No description provided for @healthWeightGoal.
  ///
  /// In de, this message translates to:
  /// **'Zielgewicht'**
  String get healthWeightGoal;

  /// No description provided for @healthHeartRate.
  ///
  /// In de, this message translates to:
  /// **'Herzfrequenz (Ruhend)'**
  String get healthHeartRate;

  /// No description provided for @healthConnectPermission.
  ///
  /// In de, this message translates to:
  /// **'Health Connect Zugriff'**
  String get healthConnectPermission;

  /// No description provided for @healthKitPermission.
  ///
  /// In de, this message translates to:
  /// **'Apple Health Zugriff'**
  String get healthKitPermission;

  /// No description provided for @healthNoData.
  ///
  /// In de, this message translates to:
  /// **'Keine Daten vorhanden'**
  String get healthNoData;

  /// No description provided for @nutritionTitle.
  ///
  /// In de, this message translates to:
  /// **'Ernährung'**
  String get nutritionTitle;

  /// No description provided for @nutritionCalories.
  ///
  /// In de, this message translates to:
  /// **'Kalorien'**
  String get nutritionCalories;

  /// No description provided for @nutritionProtein.
  ///
  /// In de, this message translates to:
  /// **'Protein'**
  String get nutritionProtein;

  /// No description provided for @nutritionCarbs.
  ///
  /// In de, this message translates to:
  /// **'Kohlenhydrate'**
  String get nutritionCarbs;

  /// No description provided for @nutritionFat.
  ///
  /// In de, this message translates to:
  /// **'Fett'**
  String get nutritionFat;

  /// No description provided for @nutritionWater.
  ///
  /// In de, this message translates to:
  /// **'Wasser'**
  String get nutritionWater;

  /// No description provided for @nutritionAddMeal.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit hinzufügen'**
  String get nutritionAddMeal;

  /// No description provided for @nutritionSaveTemplate.
  ///
  /// In de, this message translates to:
  /// **'Als Vorlage speichern'**
  String get nutritionSaveTemplate;

  /// No description provided for @nutritionShoppingList.
  ///
  /// In de, this message translates to:
  /// **'Einkaufsliste'**
  String get nutritionShoppingList;

  /// No description provided for @supplementTitle.
  ///
  /// In de, this message translates to:
  /// **'Supplemente'**
  String get supplementTitle;

  /// No description provided for @supplementAdd.
  ///
  /// In de, this message translates to:
  /// **'Supplement hinzufügen'**
  String get supplementAdd;

  /// No description provided for @supplementTaken.
  ///
  /// In de, this message translates to:
  /// **'Eingenommen'**
  String get supplementTaken;

  /// No description provided for @supplementPending.
  ///
  /// In de, this message translates to:
  /// **'Noch ausstehend'**
  String get supplementPending;

  /// No description provided for @supplementHistory.
  ///
  /// In de, this message translates to:
  /// **'Verlauf'**
  String get supplementHistory;

  /// No description provided for @medicationTitle.
  ///
  /// In de, this message translates to:
  /// **'Medikamente'**
  String get medicationTitle;

  /// No description provided for @medicationAdd.
  ///
  /// In de, this message translates to:
  /// **'Medikament hinzufügen'**
  String get medicationAdd;

  /// No description provided for @medicationTaken.
  ///
  /// In de, this message translates to:
  /// **'Eingenommen'**
  String get medicationTaken;

  /// No description provided for @medicationDose.
  ///
  /// In de, this message translates to:
  /// **'Dosis'**
  String get medicationDose;

  /// No description provided for @medicationCompliance.
  ///
  /// In de, this message translates to:
  /// **'Einnahmetreue'**
  String get medicationCompliance;

  /// No description provided for @abstinenceTitle.
  ///
  /// In de, this message translates to:
  /// **'Abstinenz'**
  String get abstinenceTitle;

  /// No description provided for @abstinenceAdd.
  ///
  /// In de, this message translates to:
  /// **'Tracker hinzufügen'**
  String get abstinenceAdd;

  /// No description provided for @abstinenceDays.
  ///
  /// In de, this message translates to:
  /// **'{days} Tage'**
  String abstinenceDays(int days);

  /// No description provided for @abstinenceRelapse.
  ///
  /// In de, this message translates to:
  /// **'Rückfall'**
  String get abstinenceRelapse;

  /// No description provided for @abstinenceRelapseConfirm.
  ///
  /// In de, this message translates to:
  /// **'Rückfall bestätigen'**
  String get abstinenceRelapseConfirm;

  /// No description provided for @abstinenceRelapseNote.
  ///
  /// In de, this message translates to:
  /// **'Notiz (optional)'**
  String get abstinenceRelapseNote;

  /// No description provided for @abstinenceLongestStreak.
  ///
  /// In de, this message translates to:
  /// **'Längste Streak'**
  String get abstinenceLongestStreak;

  /// No description provided for @abstinenceLastRelapse.
  ///
  /// In de, this message translates to:
  /// **'Letzter Vorfall'**
  String get abstinenceLastRelapse;

  /// No description provided for @budgetTitle.
  ///
  /// In de, this message translates to:
  /// **'Budget'**
  String get budgetTitle;

  /// No description provided for @budgetAvailable.
  ///
  /// In de, this message translates to:
  /// **'Verfügbares Guthaben'**
  String get budgetAvailable;

  /// No description provided for @budgetIncome.
  ///
  /// In de, this message translates to:
  /// **'Einnahmen'**
  String get budgetIncome;

  /// No description provided for @budgetExpenses.
  ///
  /// In de, this message translates to:
  /// **'Ausgaben'**
  String get budgetExpenses;

  /// No description provided for @budgetCategoryExpenses.
  ///
  /// In de, this message translates to:
  /// **'Ausgaben nach Kategorie'**
  String get budgetCategoryExpenses;

  /// No description provided for @budgetVsLimit.
  ///
  /// In de, this message translates to:
  /// **'Budget vs. Ausgaben'**
  String get budgetVsLimit;

  /// No description provided for @budgetOverrun.
  ///
  /// In de, this message translates to:
  /// **'{category} überschritten!'**
  String budgetOverrun(String category);

  /// No description provided for @budgetAddTransaction.
  ///
  /// In de, this message translates to:
  /// **'Transaktion hinzufügen'**
  String get budgetAddTransaction;

  /// No description provided for @budgetSavings.
  ///
  /// In de, this message translates to:
  /// **'Sparziele'**
  String get budgetSavings;

  /// No description provided for @budgetDebts.
  ///
  /// In de, this message translates to:
  /// **'Schulden'**
  String get budgetDebts;

  /// No description provided for @periodTitle.
  ///
  /// In de, this message translates to:
  /// **'Zyklus'**
  String get periodTitle;

  /// No description provided for @periodDaysUntil.
  ///
  /// In de, this message translates to:
  /// **'Periode in {days} Tagen'**
  String periodDaysUntil(int days);

  /// No description provided for @periodFertile.
  ///
  /// In de, this message translates to:
  /// **'Fruchtbar'**
  String get periodFertile;

  /// No description provided for @periodNotFertile.
  ///
  /// In de, this message translates to:
  /// **'Nicht fruchtbar'**
  String get periodNotFertile;

  /// No description provided for @periodOvulation.
  ///
  /// In de, this message translates to:
  /// **'Eisprung'**
  String get periodOvulation;

  /// No description provided for @periodEnterPeriod.
  ///
  /// In de, this message translates to:
  /// **'Periode eingeben'**
  String get periodEnterPeriod;

  /// No description provided for @periodEnterSymptoms.
  ///
  /// In de, this message translates to:
  /// **'Symptome eingeben'**
  String get periodEnterSymptoms;

  /// No description provided for @periodPregnancyChance.
  ///
  /// In de, this message translates to:
  /// **'Schwangerschaftswahrscheinlichkeit'**
  String get periodPregnancyChance;

  /// No description provided for @periodCalendar.
  ///
  /// In de, this message translates to:
  /// **'Kalender'**
  String get periodCalendar;

  /// No description provided for @periodMyCycles.
  ///
  /// In de, this message translates to:
  /// **'Meine Zyklen'**
  String get periodMyCycles;

  /// No description provided for @periodCycleTrends.
  ///
  /// In de, this message translates to:
  /// **'Zyklustrends'**
  String get periodCycleTrends;

  /// No description provided for @planningTitle.
  ///
  /// In de, this message translates to:
  /// **'Planung'**
  String get planningTitle;

  /// No description provided for @planningCalendar.
  ///
  /// In de, this message translates to:
  /// **'Kalender'**
  String get planningCalendar;

  /// No description provided for @planningTodos.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben'**
  String get planningTodos;

  /// No description provided for @planningGoals.
  ///
  /// In de, this message translates to:
  /// **'Ziele'**
  String get planningGoals;

  /// No description provided for @planningHabits.
  ///
  /// In de, this message translates to:
  /// **'Gewohnheiten'**
  String get planningHabits;

  /// No description provided for @planningAddAppointment.
  ///
  /// In de, this message translates to:
  /// **'Termin hinzufügen'**
  String get planningAddAppointment;

  /// No description provided for @planningAddTodo.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe hinzufügen'**
  String get planningAddTodo;

  /// No description provided for @planningAddGoal.
  ///
  /// In de, this message translates to:
  /// **'Ziel hinzufügen'**
  String get planningAddGoal;

  /// No description provided for @planningAddHabit.
  ///
  /// In de, this message translates to:
  /// **'Gewohnheit hinzufügen'**
  String get planningAddHabit;

  /// No description provided for @planningShowAll.
  ///
  /// In de, this message translates to:
  /// **'Alle anzeigen'**
  String get planningShowAll;

  /// No description provided for @planningDueDate.
  ///
  /// In de, this message translates to:
  /// **'Fällig'**
  String get planningDueDate;

  /// No description provided for @planningPriorityHigh.
  ///
  /// In de, this message translates to:
  /// **'Hoch'**
  String get planningPriorityHigh;

  /// No description provided for @planningPriorityMedium.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get planningPriorityMedium;

  /// No description provided for @planningPriorityLow.
  ///
  /// In de, this message translates to:
  /// **'Niedrig'**
  String get planningPriorityLow;

  /// No description provided for @planningStreakDays.
  ///
  /// In de, this message translates to:
  /// **'{days} Tage'**
  String planningStreakDays(int days);

  /// No description provided for @planningLongestStreak.
  ///
  /// In de, this message translates to:
  /// **'Längste Serie: {days} Tage'**
  String planningLongestStreak(int days);

  /// No description provided for @settingsTitle.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In de, this message translates to:
  /// **'Erscheinungsbild'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In de, this message translates to:
  /// **'App-Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeDark.
  ///
  /// In de, this message translates to:
  /// **'Dunkel'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeLight.
  ///
  /// In de, this message translates to:
  /// **'Hell'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In de, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsLanguage.
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get settingsLanguage;

  /// No description provided for @settingsUnits.
  ///
  /// In de, this message translates to:
  /// **'Einheiten'**
  String get settingsUnits;

  /// No description provided for @settingsWeightUnit.
  ///
  /// In de, this message translates to:
  /// **'Gewicht'**
  String get settingsWeightUnit;

  /// No description provided for @settingsLengthUnit.
  ///
  /// In de, this message translates to:
  /// **'Länge'**
  String get settingsLengthUnit;

  /// No description provided for @settingsTempUnit.
  ///
  /// In de, this message translates to:
  /// **'Temperatur'**
  String get settingsTempUnit;

  /// No description provided for @settingsNotifications.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen'**
  String get settingsNotifications;

  /// No description provided for @settingsPrivacy.
  ///
  /// In de, this message translates to:
  /// **'Datenschutz & Sicherheit'**
  String get settingsPrivacy;

  /// No description provided for @settingsPinBiometric.
  ///
  /// In de, this message translates to:
  /// **'PIN / Biometrie'**
  String get settingsPinBiometric;

  /// No description provided for @settingsExportData.
  ///
  /// In de, this message translates to:
  /// **'Daten exportieren'**
  String get settingsExportData;

  /// No description provided for @settingsBackup.
  ///
  /// In de, this message translates to:
  /// **'Backup erstellen'**
  String get settingsBackup;

  /// No description provided for @settingsRestore.
  ///
  /// In de, this message translates to:
  /// **'Backup wiederherstellen'**
  String get settingsRestore;

  /// No description provided for @settingsWeather.
  ///
  /// In de, this message translates to:
  /// **'Wetter'**
  String get settingsWeather;

  /// No description provided for @settingsNavigation.
  ///
  /// In de, this message translates to:
  /// **'Navigation anpassen'**
  String get settingsNavigation;

  /// No description provided for @settingsAccount.
  ///
  /// In de, this message translates to:
  /// **'Konto & App'**
  String get settingsAccount;

  /// No description provided for @settingsPeriodTracking.
  ///
  /// In de, this message translates to:
  /// **'Periodentracking'**
  String get settingsPeriodTracking;

  /// No description provided for @settingsResetOnboarding.
  ///
  /// In de, this message translates to:
  /// **'Onboarding wiederholen'**
  String get settingsResetOnboarding;

  /// No description provided for @settingsDeleteAllData.
  ///
  /// In de, this message translates to:
  /// **'Alle Daten löschen'**
  String get settingsDeleteAllData;

  /// No description provided for @settingsDeleteConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'Wirklich alle Daten löschen?'**
  String get settingsDeleteConfirmTitle;

  /// No description provided for @settingsDeleteConfirmHint.
  ///
  /// In de, this message translates to:
  /// **'Tippe LÖSCHEN zur Bestätigung'**
  String get settingsDeleteConfirmHint;

  /// No description provided for @settingsWidgets.
  ///
  /// In de, this message translates to:
  /// **'Widgets'**
  String get settingsWidgets;

  /// No description provided for @settingsSupport.
  ///
  /// In de, this message translates to:
  /// **'Support & Feedback'**
  String get settingsSupport;

  /// No description provided for @settingsVersion.
  ///
  /// In de, this message translates to:
  /// **'App-Version'**
  String get settingsVersion;

  /// No description provided for @supportBugReport.
  ///
  /// In de, this message translates to:
  /// **'Fehler melden'**
  String get supportBugReport;

  /// No description provided for @supportEmailCopied.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse kopiert: support@traum-app.de'**
  String get supportEmailCopied;

  /// No description provided for @supportBugReportHint.
  ///
  /// In de, this message translates to:
  /// **'Deine E-Mail-App öffnet sich mit einem vorausgefüllten Entwurf.'**
  String get supportBugReportHint;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In de, this message translates to:
  /// **'Willkommen bei TRAUM'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Dein persönliches System. Alles an einem Ort. 100% auf deinem Gerät.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingProfileTitle.
  ///
  /// In de, this message translates to:
  /// **'Dein Profil'**
  String get onboardingProfileTitle;

  /// No description provided for @onboardingProfilePrivacyNote.
  ///
  /// In de, this message translates to:
  /// **'Die folgenden Angaben helfen TRAUM, die App individuell auf dich einzustellen. Alle Daten bleiben lokal auf deinem Gerät.'**
  String get onboardingProfilePrivacyNote;

  /// No description provided for @onboardingNameLabel.
  ///
  /// In de, this message translates to:
  /// **'Wie sollen wir dich nennen?'**
  String get onboardingNameLabel;

  /// No description provided for @onboardingNameHint.
  ///
  /// In de, this message translates to:
  /// **'Dein Name'**
  String get onboardingNameHint;

  /// No description provided for @onboardingBirthday.
  ///
  /// In de, this message translates to:
  /// **'Geburtstag (optional)'**
  String get onboardingBirthday;

  /// No description provided for @onboardingBiologicalSex.
  ///
  /// In de, this message translates to:
  /// **'Biologisches Geschlecht'**
  String get onboardingBiologicalSex;

  /// No description provided for @onboardingSexMale.
  ///
  /// In de, this message translates to:
  /// **'Männlich'**
  String get onboardingSexMale;

  /// No description provided for @onboardingSexFemale.
  ///
  /// In de, this message translates to:
  /// **'Weiblich'**
  String get onboardingSexFemale;

  /// No description provided for @onboardingSexNone.
  ///
  /// In de, this message translates to:
  /// **'Keine Angabe'**
  String get onboardingSexNone;

  /// No description provided for @onboardingPeriodActivated.
  ///
  /// In de, this message translates to:
  /// **'Periodentracking wird für dich aktiviert.'**
  String get onboardingPeriodActivated;

  /// No description provided for @onboardingUnits.
  ///
  /// In de, this message translates to:
  /// **'Einheiten'**
  String get onboardingUnits;

  /// No description provided for @onboardingFitnessTitle.
  ///
  /// In de, this message translates to:
  /// **'Fitness & Gesundheit'**
  String get onboardingFitnessTitle;

  /// No description provided for @onboardingStepsGoal.
  ///
  /// In de, this message translates to:
  /// **'Schritte-Tagesziel'**
  String get onboardingStepsGoal;

  /// No description provided for @onboardingCurrentWeight.
  ///
  /// In de, this message translates to:
  /// **'Aktuelles Gewicht'**
  String get onboardingCurrentWeight;

  /// No description provided for @onboardingTargetWeight.
  ///
  /// In de, this message translates to:
  /// **'Zielgewicht'**
  String get onboardingTargetWeight;

  /// No description provided for @onboardingHeight.
  ///
  /// In de, this message translates to:
  /// **'Körpergröße'**
  String get onboardingHeight;

  /// No description provided for @onboardingNutritionTitle.
  ///
  /// In de, this message translates to:
  /// **'Ernährung'**
  String get onboardingNutritionTitle;

  /// No description provided for @onboardingCalorieGoal.
  ///
  /// In de, this message translates to:
  /// **'Kalorienziel täglich'**
  String get onboardingCalorieGoal;

  /// No description provided for @onboardingProteinGoal.
  ///
  /// In de, this message translates to:
  /// **'Proteinziel täglich (g)'**
  String get onboardingProteinGoal;

  /// No description provided for @onboardingWaterGoal.
  ///
  /// In de, this message translates to:
  /// **'Wasserziel täglich (ml)'**
  String get onboardingWaterGoal;

  /// No description provided for @onboardingNutritionHint.
  ///
  /// In de, this message translates to:
  /// **'Diese Werte kannst du jederzeit in den Einstellungen anpassen.'**
  String get onboardingNutritionHint;

  /// No description provided for @onboardingPeriodTitle.
  ///
  /// In de, this message translates to:
  /// **'Dein Zyklus'**
  String get onboardingPeriodTitle;

  /// No description provided for @onboardingPeriodSubtitle.
  ///
  /// In de, this message translates to:
  /// **'TRAUM berechnet deinen Zyklus, fruchtbare Tage und gibt dir täglich relevante Informationen — ohne Cloud, ohne Datenweitergabe.'**
  String get onboardingPeriodSubtitle;

  /// No description provided for @onboardingLastPeriodStart.
  ///
  /// In de, this message translates to:
  /// **'Erster Tag der letzten Periode'**
  String get onboardingLastPeriodStart;

  /// No description provided for @onboardingCycleLength.
  ///
  /// In de, this message translates to:
  /// **'Durchschnittliche Zykluslänge'**
  String get onboardingCycleLength;

  /// No description provided for @onboardingPeriodLength.
  ///
  /// In de, this message translates to:
  /// **'Durchschnittliche Periodenlänge'**
  String get onboardingPeriodLength;

  /// No description provided for @onboardingPeriodSetup.
  ///
  /// In de, this message translates to:
  /// **'Einrichten'**
  String get onboardingPeriodSetup;

  /// No description provided for @onboardingPeriodLater.
  ///
  /// In de, this message translates to:
  /// **'Später einrichten'**
  String get onboardingPeriodLater;

  /// No description provided for @onboardingNavTitle.
  ///
  /// In de, this message translates to:
  /// **'Deine Navigation'**
  String get onboardingNavTitle;

  /// No description provided for @onboardingNavSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Wähle, welche Module in deiner Leiste erscheinen sollen.'**
  String get onboardingNavSubtitle;

  /// No description provided for @onboardingHealthTitle.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsdaten'**
  String get onboardingHealthTitle;

  /// No description provided for @onboardingHealthAndroid.
  ///
  /// In de, this message translates to:
  /// **'TRAUM kann Schritte, Schlaf und Herzfrequenz automatisch aus Health Connect lesen.'**
  String get onboardingHealthAndroid;

  /// No description provided for @onboardingHealthIOS.
  ///
  /// In de, this message translates to:
  /// **'TRAUM kann Schritte, Schlaf und Herzfrequenz automatisch aus Apple Health lesen.'**
  String get onboardingHealthIOS;

  /// No description provided for @onboardingHealthAllow.
  ///
  /// In de, this message translates to:
  /// **'Zugriff erlauben'**
  String get onboardingHealthAllow;

  /// No description provided for @onboardingHealthSkip.
  ///
  /// In de, this message translates to:
  /// **'Später'**
  String get onboardingHealthSkip;

  /// No description provided for @onboardingNotifTitle.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen'**
  String get onboardingNotifTitle;

  /// No description provided for @onboardingNotifSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Erinnerungen für Medikamente, Wasser und Aufgaben.'**
  String get onboardingNotifSubtitle;

  /// No description provided for @onboardingNotifAllow.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen aktivieren'**
  String get onboardingNotifAllow;

  /// No description provided for @onboardingNotifSkip.
  ///
  /// In de, this message translates to:
  /// **'Nein danke'**
  String get onboardingNotifSkip;

  /// No description provided for @onboardingDoneTitle.
  ///
  /// In de, this message translates to:
  /// **'Alles bereit.'**
  String get onboardingDoneTitle;

  /// No description provided for @onboardingDoneSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Dein System wartet. Du kannst alle Einstellungen jederzeit anpassen.'**
  String get onboardingDoneSubtitle;

  /// No description provided for @onboardingDoneHint.
  ///
  /// In de, this message translates to:
  /// **'Deine Daten verlassen nie dieses Gerät.'**
  String get onboardingDoneHint;

  /// No description provided for @onboardingNext.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get onboardingNext;

  /// No description provided for @onboardingSkip.
  ///
  /// In de, this message translates to:
  /// **'Überspringen'**
  String get onboardingSkip;

  /// No description provided for @onboardingFinish.
  ///
  /// In de, this message translates to:
  /// **'Los geht\'s'**
  String get onboardingFinish;

  /// No description provided for @commonSave.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get commonEdit;

  /// No description provided for @commonAdd.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get commonAdd;

  /// No description provided for @commonConfirm.
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get commonConfirm;

  /// No description provided for @commonClose.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get commonClose;

  /// No description provided for @commonBack.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get commonBack;

  /// No description provided for @commonShowAll.
  ///
  /// In de, this message translates to:
  /// **'Alle anzeigen'**
  String get commonShowAll;

  /// No description provided for @commonNoData.
  ///
  /// In de, this message translates to:
  /// **'Keine Daten'**
  String get commonNoData;

  /// No description provided for @commonLoading.
  ///
  /// In de, this message translates to:
  /// **'Wird geladen…'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In de, this message translates to:
  /// **'Fehler aufgetreten'**
  String get commonError;

  /// No description provided for @commonSuccess.
  ///
  /// In de, this message translates to:
  /// **'Erfolgreich gespeichert'**
  String get commonSuccess;

  /// No description provided for @commonDays.
  ///
  /// In de, this message translates to:
  /// **'{count} Tage'**
  String commonDays(int count);

  /// No description provided for @commonHours.
  ///
  /// In de, this message translates to:
  /// **'{count} Stunden'**
  String commonHours(int count);

  /// No description provided for @commonMinutes.
  ///
  /// In de, this message translates to:
  /// **'{count} Minuten'**
  String commonMinutes(int count);

  /// No description provided for @notifMedication.
  ///
  /// In de, this message translates to:
  /// **'Medikamente'**
  String get notifMedication;

  /// No description provided for @notifSupplement.
  ///
  /// In de, this message translates to:
  /// **'Supplemente'**
  String get notifSupplement;

  /// No description provided for @notifWorkout.
  ///
  /// In de, this message translates to:
  /// **'Training'**
  String get notifWorkout;

  /// No description provided for @notifWater.
  ///
  /// In de, this message translates to:
  /// **'Wasser'**
  String get notifWater;

  /// No description provided for @notifTodo.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben'**
  String get notifTodo;

  /// No description provided for @notifHabit.
  ///
  /// In de, this message translates to:
  /// **'Gewohnheiten'**
  String get notifHabit;

  /// No description provided for @notifCalendar.
  ///
  /// In de, this message translates to:
  /// **'Kalender'**
  String get notifCalendar;

  /// No description provided for @notifHealth.
  ///
  /// In de, this message translates to:
  /// **'Gesundheit'**
  String get notifHealth;

  /// No description provided for @notifBudget.
  ///
  /// In de, this message translates to:
  /// **'Budget'**
  String get notifBudget;

  /// No description provided for @notifPeriod.
  ///
  /// In de, this message translates to:
  /// **'Zyklus'**
  String get notifPeriod;

  /// No description provided for @exercise_bench_press.
  ///
  /// In de, this message translates to:
  /// **'Bankdrücken (Langhantel)'**
  String get exercise_bench_press;

  /// No description provided for @exercise_push_up.
  ///
  /// In de, this message translates to:
  /// **'Liegestütz'**
  String get exercise_push_up;

  /// No description provided for @exercise_pull_up.
  ///
  /// In de, this message translates to:
  /// **'Klimmzug'**
  String get exercise_pull_up;

  /// No description provided for @exercise_squat.
  ///
  /// In de, this message translates to:
  /// **'Kniebeuge'**
  String get exercise_squat;

  /// No description provided for @exercise_deadlift.
  ///
  /// In de, this message translates to:
  /// **'Kreuzheben'**
  String get exercise_deadlift;

  /// No description provided for @exercise_shoulder_press.
  ///
  /// In de, this message translates to:
  /// **'Schulterdrücken'**
  String get exercise_shoulder_press;

  /// No description provided for @exercise_bicep_curl.
  ///
  /// In de, this message translates to:
  /// **'Bizepscurl'**
  String get exercise_bicep_curl;

  /// No description provided for @exercise_tricep_dip.
  ///
  /// In de, this message translates to:
  /// **'Trizepsdrücken'**
  String get exercise_tricep_dip;

  /// No description provided for @exercise_plank.
  ///
  /// In de, this message translates to:
  /// **'Plank'**
  String get exercise_plank;

  /// No description provided for @exercise_running.
  ///
  /// In de, this message translates to:
  /// **'Laufen'**
  String get exercise_running;

  /// No description provided for @exercise_incline_press.
  ///
  /// In de, this message translates to:
  /// **'Schrägbankdrücken'**
  String get exercise_incline_press;

  /// No description provided for @exercise_chest_fly.
  ///
  /// In de, this message translates to:
  /// **'Fliegende Brust'**
  String get exercise_chest_fly;

  /// No description provided for @exercise_cable_crossover.
  ///
  /// In de, this message translates to:
  /// **'Kabelzug Kreuzung'**
  String get exercise_cable_crossover;

  /// No description provided for @exercise_dip.
  ///
  /// In de, this message translates to:
  /// **'Dip'**
  String get exercise_dip;

  /// No description provided for @exercise_lat_pulldown.
  ///
  /// In de, this message translates to:
  /// **'Latzug'**
  String get exercise_lat_pulldown;

  /// No description provided for @exercise_bent_row.
  ///
  /// In de, this message translates to:
  /// **'Rudern vorgebeugt'**
  String get exercise_bent_row;

  /// No description provided for @exercise_seated_row.
  ///
  /// In de, this message translates to:
  /// **'Rudern sitzend'**
  String get exercise_seated_row;

  /// No description provided for @exercise_pullover.
  ///
  /// In de, this message translates to:
  /// **'Pullover'**
  String get exercise_pullover;

  /// No description provided for @exercise_face_pull.
  ///
  /// In de, this message translates to:
  /// **'Face Pull'**
  String get exercise_face_pull;

  /// No description provided for @exercise_lateral_raise.
  ///
  /// In de, this message translates to:
  /// **'Seitheben'**
  String get exercise_lateral_raise;

  /// No description provided for @exercise_front_raise.
  ///
  /// In de, this message translates to:
  /// **'Vorwaärtsheben'**
  String get exercise_front_raise;

  /// No description provided for @exercise_rear_delt_fly.
  ///
  /// In de, this message translates to:
  /// **'Hinteres Deltaheben'**
  String get exercise_rear_delt_fly;

  /// No description provided for @exercise_hammer_curl.
  ///
  /// In de, this message translates to:
  /// **'Hammer Curl'**
  String get exercise_hammer_curl;

  /// No description provided for @exercise_concentration_curl.
  ///
  /// In de, this message translates to:
  /// **'Konzentrations Curl'**
  String get exercise_concentration_curl;

  /// No description provided for @exercise_skull_crusher.
  ///
  /// In de, this message translates to:
  /// **'Skull Crusher'**
  String get exercise_skull_crusher;

  /// No description provided for @exercise_overhead_tricep.
  ///
  /// In de, this message translates to:
  /// **'Trizeps über Kopf'**
  String get exercise_overhead_tricep;

  /// No description provided for @exercise_leg_press.
  ///
  /// In de, this message translates to:
  /// **'Beinpresse'**
  String get exercise_leg_press;

  /// No description provided for @exercise_leg_curl.
  ///
  /// In de, this message translates to:
  /// **'Beinbeuger'**
  String get exercise_leg_curl;

  /// No description provided for @exercise_leg_extension.
  ///
  /// In de, this message translates to:
  /// **'Beinstrecker'**
  String get exercise_leg_extension;

  /// No description provided for @exercise_calf_raise.
  ///
  /// In de, this message translates to:
  /// **'Wadenheben'**
  String get exercise_calf_raise;

  /// No description provided for @exercise_lunge.
  ///
  /// In de, this message translates to:
  /// **'Ausfallschritt'**
  String get exercise_lunge;

  /// No description provided for @exercise_glute_bridge.
  ///
  /// In de, this message translates to:
  /// **'Gesäßbrücke'**
  String get exercise_glute_bridge;

  /// No description provided for @exercise_crunch.
  ///
  /// In de, this message translates to:
  /// **'Crunch'**
  String get exercise_crunch;

  /// No description provided for @exercise_russian_twist.
  ///
  /// In de, this message translates to:
  /// **'Russian Twist'**
  String get exercise_russian_twist;

  /// No description provided for @exercise_leg_raise.
  ///
  /// In de, this message translates to:
  /// **'Beinheben'**
  String get exercise_leg_raise;

  /// No description provided for @exercise_mountain_climber.
  ///
  /// In de, this message translates to:
  /// **'Mountain Climber'**
  String get exercise_mountain_climber;

  /// No description provided for @exercise_bicycle_crunch.
  ///
  /// In de, this message translates to:
  /// **'Fahrradsitz'**
  String get exercise_bicycle_crunch;

  /// No description provided for @exercise_cycling.
  ///
  /// In de, this message translates to:
  /// **'Radfahren'**
  String get exercise_cycling;

  /// No description provided for @exercise_rowing.
  ///
  /// In de, this message translates to:
  /// **'Rudern'**
  String get exercise_rowing;

  /// No description provided for @exercise_jump_rope.
  ///
  /// In de, this message translates to:
  /// **'Seilspringen'**
  String get exercise_jump_rope;

  /// No description provided for @exercise_burpee.
  ///
  /// In de, this message translates to:
  /// **'Burpee'**
  String get exercise_burpee;

  /// No description provided for @exercise_jumping_jack.
  ///
  /// In de, this message translates to:
  /// **'Hampelmann'**
  String get exercise_jumping_jack;

  /// No description provided for @exercise_clean.
  ///
  /// In de, this message translates to:
  /// **'Clean'**
  String get exercise_clean;

  /// No description provided for @exercise_snatch.
  ///
  /// In de, this message translates to:
  /// **'Reißen'**
  String get exercise_snatch;

  /// No description provided for @exercise_thruster.
  ///
  /// In de, this message translates to:
  /// **'Thruster'**
  String get exercise_thruster;

  /// No description provided for @exercise_box_jump.
  ///
  /// In de, this message translates to:
  /// **'Box Jump'**
  String get exercise_box_jump;

  /// No description provided for @exercise_battle_rope.
  ///
  /// In de, this message translates to:
  /// **'Battle Rope'**
  String get exercise_battle_rope;

  /// No description provided for @supplement_vitamin_d3.
  ///
  /// In de, this message translates to:
  /// **'Vitamin D3'**
  String get supplement_vitamin_d3;

  /// No description provided for @supplement_vitamin_c.
  ///
  /// In de, this message translates to:
  /// **'Vitamin C'**
  String get supplement_vitamin_c;

  /// No description provided for @supplement_vitamin_b12.
  ///
  /// In de, this message translates to:
  /// **'Vitamin B12'**
  String get supplement_vitamin_b12;

  /// No description provided for @supplement_vitamin_a.
  ///
  /// In de, this message translates to:
  /// **'Vitamin A'**
  String get supplement_vitamin_a;

  /// No description provided for @supplement_vitamin_e.
  ///
  /// In de, this message translates to:
  /// **'Vitamin E'**
  String get supplement_vitamin_e;

  /// No description provided for @supplement_vitamin_k2.
  ///
  /// In de, this message translates to:
  /// **'Vitamin K2'**
  String get supplement_vitamin_k2;

  /// No description provided for @supplement_vitamin_b_complex.
  ///
  /// In de, this message translates to:
  /// **'Vitamin B-Komplex'**
  String get supplement_vitamin_b_complex;

  /// No description provided for @supplement_magnesium.
  ///
  /// In de, this message translates to:
  /// **'Magnesium'**
  String get supplement_magnesium;

  /// No description provided for @supplement_zinc.
  ///
  /// In de, this message translates to:
  /// **'Zink'**
  String get supplement_zinc;

  /// No description provided for @supplement_iron.
  ///
  /// In de, this message translates to:
  /// **'Eisen'**
  String get supplement_iron;

  /// No description provided for @supplement_calcium.
  ///
  /// In de, this message translates to:
  /// **'Calcium'**
  String get supplement_calcium;

  /// No description provided for @supplement_selenium.
  ///
  /// In de, this message translates to:
  /// **'Selen'**
  String get supplement_selenium;

  /// No description provided for @supplement_creatine.
  ///
  /// In de, this message translates to:
  /// **'Kreatin'**
  String get supplement_creatine;

  /// No description provided for @supplement_l_glutamine.
  ///
  /// In de, this message translates to:
  /// **'L-Glutamin'**
  String get supplement_l_glutamine;

  /// No description provided for @supplement_bcaa.
  ///
  /// In de, this message translates to:
  /// **'BCAA'**
  String get supplement_bcaa;

  /// No description provided for @supplement_l_arginine.
  ///
  /// In de, this message translates to:
  /// **'L-Arginin'**
  String get supplement_l_arginine;

  /// No description provided for @supplement_whey_protein.
  ///
  /// In de, this message translates to:
  /// **'Whey Protein'**
  String get supplement_whey_protein;

  /// No description provided for @supplement_casein.
  ///
  /// In de, this message translates to:
  /// **'Casein Protein'**
  String get supplement_casein;

  /// No description provided for @supplement_vegan_protein.
  ///
  /// In de, this message translates to:
  /// **'Veganes Protein'**
  String get supplement_vegan_protein;

  /// No description provided for @supplement_omega3.
  ///
  /// In de, this message translates to:
  /// **'Omega-3'**
  String get supplement_omega3;

  /// No description provided for @supplement_fish_oil.
  ///
  /// In de, this message translates to:
  /// **'Fischöl'**
  String get supplement_fish_oil;

  /// No description provided for @supplement_ashwagandha.
  ///
  /// In de, this message translates to:
  /// **'Ashwagandha'**
  String get supplement_ashwagandha;

  /// No description provided for @supplement_rhodiola.
  ///
  /// In de, this message translates to:
  /// **'Rhodiola'**
  String get supplement_rhodiola;

  /// No description provided for @supplement_caffeine.
  ///
  /// In de, this message translates to:
  /// **'Koffein'**
  String get supplement_caffeine;

  /// No description provided for @supplement_beta_alanine.
  ///
  /// In de, this message translates to:
  /// **'Beta-Alanin'**
  String get supplement_beta_alanine;

  /// No description provided for @supplement_citrulline.
  ///
  /// In de, this message translates to:
  /// **'Citrullin'**
  String get supplement_citrulline;

  /// No description provided for @supplement_probiotics.
  ///
  /// In de, this message translates to:
  /// **'Probiotika'**
  String get supplement_probiotics;

  /// No description provided for @supplement_prebiotics.
  ///
  /// In de, this message translates to:
  /// **'Präbiotika'**
  String get supplement_prebiotics;

  /// No description provided for @weatherClear.
  ///
  /// In de, this message translates to:
  /// **'Klar'**
  String get weatherClear;

  /// No description provided for @weatherMostlyClear.
  ///
  /// In de, this message translates to:
  /// **'Überwiegend klar'**
  String get weatherMostlyClear;

  /// No description provided for @weatherPartlyCloudy.
  ///
  /// In de, this message translates to:
  /// **'Teilweise bewölkt'**
  String get weatherPartlyCloudy;

  /// No description provided for @weatherOvercast.
  ///
  /// In de, this message translates to:
  /// **'Bewölkt'**
  String get weatherOvercast;

  /// No description provided for @weatherFoggy.
  ///
  /// In de, this message translates to:
  /// **'Neblig'**
  String get weatherFoggy;

  /// No description provided for @weatherDrizzle.
  ///
  /// In de, this message translates to:
  /// **'Nieselregen'**
  String get weatherDrizzle;

  /// No description provided for @weatherRain.
  ///
  /// In de, this message translates to:
  /// **'Regen'**
  String get weatherRain;

  /// No description provided for @weatherSnowfall.
  ///
  /// In de, this message translates to:
  /// **'Schneefall'**
  String get weatherSnowfall;

  /// No description provided for @weatherSnowGrains.
  ///
  /// In de, this message translates to:
  /// **'Schneegriesel'**
  String get weatherSnowGrains;

  /// No description provided for @weatherRainShowers.
  ///
  /// In de, this message translates to:
  /// **'Regenschauer'**
  String get weatherRainShowers;

  /// No description provided for @weatherSnowShowers.
  ///
  /// In de, this message translates to:
  /// **'Schneeschauer'**
  String get weatherSnowShowers;

  /// No description provided for @weatherThunderstorm.
  ///
  /// In de, this message translates to:
  /// **'Gewitter'**
  String get weatherThunderstorm;

  /// No description provided for @weatherHeavyThunderstorm.
  ///
  /// In de, this message translates to:
  /// **'Starkes Gewitter'**
  String get weatherHeavyThunderstorm;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
