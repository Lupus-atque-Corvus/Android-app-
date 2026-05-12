# TRAUM — Vollständige App-Dokumentation für Claude Code

> Diese Datei beschreibt den **gesamten aktuellen Zustand** der TRAUM Flutter App.
> Verwende sie als Grundlage für alle weiteren Entwicklungsaufgaben.
> Branch: `claude/new-session-y2Jyo` · Version: `1.0.0+1`

---

## Inhaltsverzeichnis

1. [Projektübersicht](#1-projektübersicht)
2. [Tech Stack](#2-tech-stack)
3. [Verzeichnisstruktur](#3-verzeichnisstruktur)
4. [Design System](#4-design-system)
5. [Datenbank — alle 33 Tabellen](#5-datenbank--alle-33-tabellen)
6. [SharedPreferences — alle Keys](#6-sharedpreferences--alle-keys)
7. [Riverpod Provider](#7-riverpod-provider)
8. [Navigation & Routing](#8-navigation--routing)
9. [App-Start & Initialisierung](#9-app-start--initialisierung)
10. [Onboarding](#10-onboarding)
11. [Home-Screen](#11-home-screen)
12. [Modul: Training](#12-modul-training)
13. [Modul: Gesundheit (Health)](#13-modul-gesundheit-health)
14. [Modul: Ernährung (Nutrition)](#14-modul-ernährung-nutrition)
15. [Modul: Supplements](#15-modul-supplements)
16. [Modul: Planung (Planning)](#16-modul-planung-planning)
17. [Modul: Medikamente (Medication)](#17-modul-medikamente-medication)
18. [Modul: Abstinenz (Abstinence)](#18-modul-abstinenz-abstinence)
19. [Modul: Budget](#19-modul-budget)
20. [Modul: Zyklustracking (Period)](#20-modul-zyklustracking-period)
21. [Modul: Einstellungen (Settings)](#21-modul-einstellungen-settings)
22. [Benachrichtigungen](#22-benachrichtigungen)
23. [Homescreen-Widgets](#23-homescreen-widgets)
24. [Lokalisierung (i18n)](#24-lokalisierung-i18n)
25. [Core Components](#25-core-components)
26. [Android-Native (Kotlin)](#26-android-native-kotlin)
27. [iOS-Native (Swift/WidgetKit)](#27-ios-native-swiftwidgetkit)
28. [Bekannte Architekturentscheidungen](#28-bekannte-architekturentscheidungen)
29. [Wichtige Konventionen](#29-wichtige-konventionen)

---

## 1. Projektübersicht

**Name:** TRAUM  
**App-ID:** `de.traum.traum`  
**Plattformen:** Android (minSdk 26) · iOS (min 16.0)  
**Sprache:** Dart / Flutter  
**Datenablage:** ausschließlich lokal — kein Backend, kein Server, kein Internet-Pflicht  
**Standardsprache der UI:** Deutsch (9 Sprachen verfügbar)  
**Standardthema:** Dark Mode

TRAUM ist ein persönliches Dashboard mit 11 Modulen:
Home · Training · Gesundheit · Ernährung · Supplements · Planung ·
Medikamente · Abstinenz · Budget · Zyklustracking · Einstellungen

---

## 2. Tech Stack

| Bereich | Paket | Version |
|---------|-------|---------|
| State | `flutter_riverpod` | ^2.5.1 |
| State (Annotation) | `riverpod_annotation` | ^2.3.5 |
| Navigation | `go_router` | ^14.0.0 |
| Datenbank | `drift` + `sqlite3_flutter_libs` | ^2.20.0 |
| Preferences | `shared_preferences` | ^2.3.2 |
| Sichere Präfs | `flutter_secure_storage` | ^9.2.2 |
| Gesundheitsdaten | `health` | ^11.0.0 |
| Charts | `fl_chart` | ^0.69.0 |
| Benachrichtigungen | `flutter_local_notifications` | ^17.2.3 |
| Background-Tasks | `workmanager` | ^0.5.2 |
| Homescreen-Widgets | `home_widget` | ^0.6.0 |
| Biometrie | `local_auth` | ^2.3.0 |
| HTTP | `http` | ^1.2.2 |
| Schrift | `google_fonts` | ^6.2.1 |
| Animationen | `lottie` | ^3.1.2 |
| GPS | `geolocator` | ^12.0.0 |
| Teilen | `share_plus` | ^10.0.0 |
| Archiv | `archive` | ^3.6.0 |
| Links | `url_launcher` | ^6.3.0 |
| App-Info | `package_info_plus` | ^8.0.0 |
| Bilder | `image_picker` | ^1.1.2 |
| i18n | `flutter_localizations` (SDK) + `intl` | ^0.19.0 |
| Permissions | `permission_handler` | ^11.3.1 |
| Zeitzone | `timezone` + `flutter_timezone` | ^0.9.4 / ^1.0.4 |
| Pfade | `path` + `path_provider` | |
| Code-Gen | `build_runner`, `drift_dev`, `riverpod_generator` | |

---

## 3. Verzeichnisstruktur

```
lib/
├── main.dart                          # Entry Point
├── app.dart                           # MaterialApp.router
│
├── core/
│   ├── components/                    # 12 wiederverwendbare Widgets
│   │   ├── components.dart            # Barrel-Export
│   │   ├── traum_card.dart
│   │   ├── gradient_button.dart
│   │   ├── gradient_progress_bar.dart
│   │   ├── circular_progress_ring.dart
│   │   ├── appointment_chip.dart
│   │   ├── section_header.dart
│   │   ├── habit_week_row.dart
│   │   ├── traum_line_chart.dart
│   │   ├── donut_chart.dart
│   │   ├── budget_category_bar.dart
│   │   ├── shimmer_loader.dart
│   │   └── medication_dot_row.dart
│   │
│   ├── navigation/
│   │   ├── routes.dart                # Alle Route-Pfad-Konstanten
│   │   ├── router.dart                # GoRouter + ShellRoute + Redirect
│   │   └── traum_scaffold.dart        # Shell mit dynamischer BottomNav (5 Slots)
│   │
│   ├── notifications/
│   │   ├── notification_service.dart  # Init, Channels, scheduleDailyAt, rescheduleAll
│   │   └── notification_prefs.dart    # Typed SharedPrefs für Notification-Toggles
│   │
│   ├── providers/
│   │   ├── database_provider.dart     # TraumDatabase + alle DAO Provider
│   │   ├── preferences_provider.dart  # themeProvider, localeProvider, navSlotsProvider, …
│   │   └── repository_providers.dart  # Ein Provider pro Repository
│   │
│   ├── theme/
│   │   ├── colors.dart                # TraumColors (alle statischen Konstanten)
│   │   ├── radius.dart                # TraumRadius
│   │   ├── typography.dart            # DM Sans TextTheme
│   │   ├── traum_theme.dart           # TraumTheme.dark / .light (ThemeData)
│   │   └── theme.dart                 # Theme-Helper
│   │
│   └── utils/
│       ├── date_utils.dart            # formatDate(), greeting()
│       ├── formatters.dart            # currency, duration, weight
│       └── streak.dart                # calculateStreak()
│
├── data/
│   ├── database/
│   │   ├── traum_database.dart        # @DriftDatabase — 33 Tabellen, 9 DAOs
│   │   ├── traum_database.g.dart      # Code-Generated
│   │   ├── tables/                    # 9 Tabellen-Dateien (eine pro Modul)
│   │   └── daos/                      # 9 DAO-Dateien + .g.dart
│   │
│   ├── preferences/
│   │   └── preferences_repository.dart  # ~50 typisierte Keys
│   │
│   └── repositories/                  # 9 Repository-Klassen + 3 Seeder
│       ├── planning_repository.dart
│       ├── training_repository.dart
│       ├── health_repository.dart
│       ├── nutrition_repository.dart
│       ├── supplement_repository.dart
│       ├── medication_repository.dart
│       ├── abstinence_repository.dart
│       ├── budget_repository.dart
│       ├── period_repository.dart
│       ├── exercise_seeder.dart        # Lädt assets/exercises/*.json in DB
│       ├── supplement_seeder.dart      # Lädt assets/supplements/*.json in DB
│       └── medication_seeder.dart
│
├── features/
│   ├── onboarding/
│   │   └── onboarding_screen.dart     # 9-seitiger PageView
│   ├── home/
│   │   └── home_screen.dart
│   ├── training/
│   │   ├── training_screen.dart
│   │   ├── active_workout_screen.dart
│   │   ├── exercise_library_screen.dart
│   │   ├── workout_detail_screen.dart
│   │   └── exercise_progress_screen.dart
│   ├── health/
│   │   └── health_screen.dart
│   ├── nutrition/
│   │   ├── nutrition_screen.dart
│   │   ├── meal_log_screen.dart
│   │   ├── food_search_screen.dart
│   │   └── shopping_list_screen.dart
│   ├── supplements/
│   │   └── supplement_screen.dart
│   ├── planning/
│   │   └── planning_screen.dart
│   ├── medication/
│   │   └── medication_screen.dart
│   ├── abstinence/
│   │   └── abstinence_screen.dart
│   ├── budget/
│   │   ├── budget_screen.dart
│   │   ├── add_transaction_screen.dart
│   │   ├── transaction_list_screen.dart
│   │   ├── budget_stats_screen.dart
│   │   └── savings_screen.dart
│   ├── period_tracking/
│   │   ├── cycle_calculator.dart      # Pure Dart, kein Flutter
│   │   ├── period_screen.dart
│   │   ├── period_calendar_screen.dart
│   │   └── cycle_history_screen.dart
│   └── settings/
│       └── settings_screen.dart
│
├── l10n/                              # Generierte ARB-Klassen (9 Sprachen)
│   ├── app_localizations.dart
│   ├── app_localizations_de.dart      # Deutsch (Template)
│   ├── app_localizations_en.dart
│   ├── app_localizations_zh.dart
│   ├── app_localizations_hi.dart
│   ├── app_localizations_es.dart
│   ├── app_localizations_fr.dart
│   ├── app_localizations_ar.dart
│   ├── app_localizations_pt.dart
│   └── app_localizations_ru.dart
│
└── widget/
    └── widget_data_service.dart       # HomeWidget Bridge (24 Keys, 11 Providers)

assets/
├── exercises/                         # 9 JSON-Dateien (Muskelgruppen)
│   ├── chest.json, back.json, shoulders.json, biceps.json
│   ├── triceps.json, legs.json, core.json, cardio.json, full_body.json
└── supplements/                       # 9 JSON-Dateien (Kategorien)
    ├── vitamins.json, minerals.json, amino_acids.json, protein.json
    ├── omega.json, adaptogens.json, pre_workout.json
    ├── gut_health.json, creatine.json

android/app/src/main/kotlin/de/traum/traum/
├── MainActivity.kt
├── Traum*WidgetProvider.kt            # 11 AppWidgetProvider-Klassen
└── workers/                           # 8 WorkManager Worker-Klassen

android/app/src/main/res/
├── layout/widget_*.xml                # 11 XML-Layouts für Homescreen-Widgets
└── xml/widget_*_info.xml              # 11 AppWidget-Provider-Metadaten

ios/
├── Runner/
│   ├── Info.plist                     # Permissions + AppGroupIdentifier
│   └── Runner.entitlements            # HealthKit + App Group
└── TraumWidgets/
    └── TraumWidgets.swift             # @main WidgetBundle mit 11 SwiftUI-Widgets
```

---

## 4. Design System

### Farben (`lib/core/theme/colors.dart`)

```dart
// Hintergründe
background     = #0D0D1A   // App-Hintergrund (Dark)
surface        = #1A1A2E   // Karten-Hintergrund
surfaceVariant = #22223A   // Eingabefelder, Chips
bottomNav      = #12121F   // Bottom Navigation Bar

// Text
onBackground      = #FFFFFF   // Primärtext
onBackgroundMuted = #8888AA   // Sekundärtext
onBackgroundSubtle= #555577   // Subtiler Text

// Akzente Warm
coralOrange = #FF6B3D   // Haupt-Akzent, aktive Icons, FABs
peachOrange = #FFAA55   // Gradient-Partner
coralDim    = #33FF6B3D // Gedimmter Akzent

// Akzente Cool
cyanBlue      = #00D4D4   // Sekundärer Akzent, Charts
turquoiseBlue = #0099BB   // Gradient-Partner
cyanDim       = #3300D4D4 // Gedimmter Akzent

// Status
success    = #2DD4BF
warning    = #FFB347
error      = #FF4466
overbudget = #FF4466

// Zyklus-Spezifisch
periodRose    = #FF8FAB
ovulationCyan = #00C9C8
fertileCyan   = #0093AB

// Light-Theme
backgroundLight = #F5F5FA
surfaceLight    = #FFFFFF
onBackgroundLight = #1A1A2E

// Gradienten (LinearGradient)
gradientWarm       → coralOrange → peachOrange
gradientCool       → cyanBlue → turquoiseBlue
gradientAccent     → coralOrange → cyanBlue
gradientBudgetLine → peachOrange → coralOrange
cycleGradient      → #FF7E5F → #00C9C8
```

### Typografie
- Schriftart: **DM Sans** (Google Fonts)
- `displayLarge`: 52sp — Haupt-Countdown-Zahlen
- `titleLarge`: Kartentitel
- `bodyMedium`: Standardtext
- `bodySmall`: Labels, Beschriftungen

### Form
- Card-Radius: **20px** (`TraumRadius.card = 20`)
- Button-Radius: **50px** (Pill-Form)
- Chip-Radius: **50px**
- Bottom-Nav obere Ecken: **20px**

### Themes
- `TraumTheme.dark` — Standard
- `TraumTheme.light` — hell
- Umschaltbar via Settings → in `PreferencesRepository.appTheme` gespeichert
- Material 3 aktiv (`useMaterial3: true`)

---

## 5. Datenbank — alle 33 Tabellen

**Datei:** `lib/data/database/traum_database.dart`  
**Engine:** Drift (SQLite), `schemaVersion: 1`  
**Datei-Pfad:** `<AppDocumentsDir>/traum.sqlite`

### Modul: Planning (6 Tabellen)

```
Appointments
  id            INTEGER PK
  title         TEXT
  description   TEXT?
  location      TEXT?
  startTime     DATETIME
  endTime       DATETIME?
  allDay        BOOLEAN default false
  recurrenceRule TEXT?
  color         INTEGER?
  createdAt     DATETIME default now

Todos
  id          INTEGER PK
  title       TEXT
  note        TEXT?
  priority    INTEGER default 0
  done        BOOLEAN default false
  dueDate     DATETIME?
  completedAt DATETIME?
  createdAt   DATETIME default now

Goals
  id           INTEGER PK
  title        TEXT
  description  TEXT?
  targetValue  INTEGER?
  currentValue INTEGER default 0
  unit         TEXT?
  targetDate   DATETIME?
  done         BOOLEAN default false
  createdAt    DATETIME default now

SubTasks
  id        INTEGER PK
  goalId    INTEGER FK→Goals
  title     TEXT
  done      BOOLEAN default false
  sortOrder INTEGER default 0

Habits
  id           INTEGER PK
  name         TEXT
  emoji        TEXT?
  frequency    TEXT default 'daily'
  reminderTime TEXT?
  createdAt    DATETIME default now

HabitLogs
  id       INTEGER PK
  habitId  INTEGER FK→Habits
  logDate  DATETIME
  done     BOOLEAN default true
```

### Modul: Training (5 Tabellen)

```
WorkoutPlans
  id          INTEGER PK
  name        TEXT
  description TEXT?
  isActive    BOOLEAN default false
  createdAt   DATETIME default now

WorkoutDays
  id        INTEGER PK
  planId    INTEGER FK→WorkoutPlans
  name      TEXT
  dayOfWeek INTEGER?
  sortOrder INTEGER default 0

Exercises
  id           INTEGER PK
  name         TEXT
  muscleGroup  TEXT            ← 'chest'|'back'|'shoulders'|'biceps'|'triceps'|'legs'|'core'|'cardio'|'full_body'
  equipment    TEXT?
  instructions TEXT?
  isCustom     BOOLEAN default false

WorkoutSessions
  id              INTEGER PK
  planId          INTEGER FK→WorkoutPlans (nullable)
  dayId           INTEGER FK→WorkoutDays (nullable)
  startedAt       DATETIME
  completedAt     DATETIME?
  notes           TEXT?
  durationSeconds INTEGER?

WorkoutSets
  id              INTEGER PK
  sessionId       INTEGER FK→WorkoutSessions
  exerciseId      INTEGER FK→Exercises
  setNumber       INTEGER
  weightKg        REAL?
  reps            INTEGER?
  durationSeconds INTEGER?
  setType         TEXT default 'normal'   ← 'normal'|'superset'|'dropset'
  isWarmup        BOOLEAN default false
```

### Modul: Health (5 Tabellen)

```
WeightLogs
  id       INTEGER PK
  weightKg REAL
  logDate  DATETIME
  note     TEXT?

BodyMeasurements
  id         INTEGER PK
  logDate    DATETIME
  chestCm    REAL?
  waistCm    REAL?
  hipsCm     REAL?
  thighCm    REAL?
  bicepCm    REAL?
  shoulderCm REAL?
  calfCm     REAL?
  neckCm     REAL?
  bodyFatPct REAL?

SleepLogs
  id           INTEGER PK
  bedtime      DATETIME
  wakeTime     DATETIME
  qualityStars INTEGER?   ← 1–5
  note         TEXT?

MoodLogs
  id        INTEGER PK
  logDate   DATETIME
  moodScore INTEGER     ← 1–5
  note      TEXT?

PhotoLogs
  id        INTEGER PK
  logDate   DATETIME
  imagePath TEXT
  category  TEXT default 'front'   ← 'front'|'side'|'back'
  note      TEXT?
```

### Modul: Nutrition (4 Tabellen)

```
NutritionLogs
  id         INTEGER PK
  logDate    DATETIME
  mealType   TEXT default 'snack'   ← 'breakfast'|'lunch'|'dinner'|'snack'
  foodName   TEXT
  amountGrams REAL
  kcal       REAL
  proteinG   REAL default 0
  carbsG     REAL default 0
  fatG       REAL default 0
  templateId INTEGER?

MealTemplates
  id            INTEGER PK
  name          TEXT
  category      TEXT?
  servingSizeG  REAL
  kcalPer100g   REAL
  proteinPer100g REAL default 0
  carbsPer100g  REAL default 0
  fatPer100g    REAL default 0
  isCustom      BOOLEAN default false
  createdAt     DATETIME default now

WaterLogs
  id       INTEGER PK
  logDate  DATETIME
  amountMl INTEGER

ShoppingListItems
  id        INTEGER PK
  name      TEXT
  category  TEXT?
  quantity  REAL?
  unit      TEXT?
  checked   BOOLEAN default false
  createdAt DATETIME default now
```

### Modul: Supplements (2 Tabellen)

```
Supplements
  id           INTEGER PK
  name         TEXT
  category     TEXT?
  dosageAmount TEXT?
  dosageUnit   TEXT?
  timings      TEXT default '[]'   ← JSON-Array von Strings
  notes        TEXT?
  isActive     BOOLEAN default true
  createdAt    DATETIME default now

SupplementLogs
  id           INTEGER PK
  supplementId INTEGER FK→Supplements
  takenAt      DATETIME
  timing       TEXT?
```

### Modul: Medication (2 Tabellen)

```
Medications
  id             INTEGER PK
  name           TEXT
  dosage         TEXT?
  form           TEXT?             ← 'Tablette'|'Kapsel'|'Tropfen'|…
  timings        TEXT default '[]' ← JSON-Array von Zeiten
  instructions   TEXT?
  isActive       BOOLEAN default true
  notificationId INTEGER?
  createdAt      DATETIME default now

MedicationLogs
  id           INTEGER PK
  medicationId INTEGER FK→Medications
  scheduledAt  DATETIME
  takenAt      DATETIME?
  taken        BOOLEAN default false
  skipped      BOOLEAN default false
```

### Modul: Abstinence (2 Tabellen)

```
AbstinenceTrackers
  id        INTEGER PK
  name      TEXT
  emoji     TEXT?
  startDate DATETIME
  note      TEXT?
  isActive  BOOLEAN default true
  createdAt DATETIME default now

AbstinenceEvents
  id        INTEGER PK
  trackerId INTEGER FK→AbstinenceTrackers
  type      TEXT    ← 'relapse'|'milestone'
  eventDate DATETIME
  note      TEXT?
```

### Modul: Budget (4 Tabellen)

```
Transactions
  id          INTEGER PK
  amount      REAL
  description TEXT
  categoryId  INTEGER FK→BudgetCategories (nullable)
  type        TEXT default 'expense'   ← 'income'|'expense'
  date        DATETIME
  note        TEXT?
  createdAt   DATETIME default now

BudgetCategories
  id           INTEGER PK
  name         TEXT
  emoji        TEXT?
  monthlyLimit REAL?
  color        INTEGER?
  isExpense    BOOLEAN default true

SavingsGoals
  id            INTEGER PK
  name          TEXT
  targetAmount  REAL
  currentAmount REAL default 0
  targetDate    DATETIME?
  note          TEXT?
  isCompleted   BOOLEAN default false
  createdAt     DATETIME default now

Debts
  id             INTEGER PK
  creditor       TEXT
  originalAmount REAL
  remainingAmount REAL
  interestRate   REAL default 0
  dueDate        DATETIME?
  note           TEXT?
  isPaidOff      BOOLEAN default false
  createdAt      DATETIME default now
```

### Modul: Period (3 Tabellen)

```
PeriodEntries
  id            INTEGER PK
  startDate     DATETIME
  endDate       DATETIME?
  flowIntensity INTEGER default 2   ← 1–4
  note          TEXT?

CycleCalculations
  id               INTEGER PK
  periodEntryId    INTEGER FK→PeriodEntries
  cycleLength      INTEGER
  ovulationDate    DATETIME?
  fertileStart     DATETIME?
  fertileEnd       DATETIME?
  nextPeriodPredicted DATETIME?

PeriodSymptoms
  id        INTEGER PK
  logDate   DATETIME
  symptom   TEXT     ← 'Krämpfe'|'Kopfschmerzen'|'Stimmungsschwankungen'|…
  intensity INTEGER default 1
  note      TEXT?
```

---

## 6. SharedPreferences — alle Keys

**Datei:** `lib/data/preferences/preferences_repository.dart`

| Key | Typ | Default | Beschreibung |
|-----|-----|---------|--------------|
| `user_name` | String | `''` | Benutzername |
| `user_birthday_ms` | int | null | Birthday als Millisekunden |
| `user_biological_sex` | String | `'other'` | `'male'`/`'female'`/`'other'` |
| `unit_system` | String | `'metric'` | `'metric'`/`'imperial'` |
| `app_theme` | String | `'dark'` | `'dark'`/`'light'`/`'system'` |
| `app_locale` | String? | null | Sprachcode z.B. `'de'` |
| `nav_slots` | String | JSON-Array 5 Module | JSON-Array mit 5 Modul-Keys |
| `onboarding_complete` | bool | false | |
| `steps_goal` | int | 10000 | |
| `weight_goal_kg` | double | 75.0 | |
| `height_cm` | double | 175.0 | |
| `kcal_goal` | int | 2000 | |
| `protein_goal_g` | int | 150 | |
| `water_goal_ml` | int | 2500 | |
| `period_tracking_enabled` | bool | auto (female=true) | |
| `avg_cycle_length` | int | 28 | |
| `avg_period_length` | int | 5 | |
| `weather_lat` | double? | null | |
| `weather_lon` | double? | null | |
| `biometric_lock` | bool | false | |
| `currency_symbol` | String | `'€'` | |
| `monthly_budget` | double | 1500.0 | |
| `notif_medication` | bool | true | |
| `notif_supplement` | bool | true | |
| `notif_workout` | bool | true | |
| `notif_water` | bool | true | |
| `notif_todo` | bool | true | |
| `notif_habit` | bool | true | |
| `notif_period` | bool | true | |
| `notif_budget` | bool | false | |
| `notif_medication_time` | String | `'08:00'` | |
| `notif_supplement_time` | String | `'09:00'` | |
| `notif_workout_time` | String | `'18:00'` | |
| `notif_water_interval` | int | 90 | Minuten |
| `notif_habit_time` | String | `'20:00'` | |
| `notif_todo_time` | String | `'07:00'` | |
| `notif_period_days` | int | 3 | Tage vorher |
| `notif_budget_threshold` | double | 0.9 | 90% Budget |
| `workout_reminder_time` | String | `'07:00'` | |
| `water_reminder_interval` | String | `'120'` | |

**Methoden:**
- `clearAll()` → `_prefs.clear()` — löscht **alle** Keys (Daten-Reset in Settings)

---

## 7. Riverpod Provider

**Datei:** `lib/core/providers/preferences_provider.dart`

```dart
sharedPreferencesProvider       Provider<SharedPreferences>   // Override im ProviderScope
preferencesRepositoryProvider   Provider<PreferencesRepository>

themeProvider                   NotifierProvider<ThemeNotifier, ThemeMode>
localeProvider                  NotifierProvider<LocaleNotifier, Locale?>

userNameProvider                Provider<String>
userBiologicalSexProvider       Provider<String>
onboardingCompleteProvider      Provider<bool>
isPeriodTrackingEnabledProvider Provider<bool>
navSlotsProvider                Provider<List<String>>
stepsGoalProvider               Provider<int>
kcalGoalProvider                Provider<int>
waterGoalMlProvider             Provider<int>
proteinGoalGProvider            Provider<int>
currencySymbolProvider          Provider<String>
unitSystemProvider              Provider<String>
```

**Datei:** `lib/core/providers/repository_providers.dart`

```dart
planningRepositoryProvider    Provider<PlanningRepository>
trainingRepositoryProvider    Provider<TrainingRepository>
healthRepositoryProvider      Provider<HealthRepository>
nutritionRepositoryProvider   Provider<NutritionRepository>
supplementRepositoryProvider  Provider<SupplementRepository>
medicationRepositoryProvider  Provider<MedicationRepository>
abstinenceRepositoryProvider  Provider<AbstinenceRepository>
budgetRepositoryProvider      Provider<BudgetRepository>
periodRepositoryProvider      Provider<PeriodRepository>
```

**Datei:** `lib/core/providers/database_provider.dart`

```dart
// TraumDatabase Singleton + je ein Provider pro DAO
```

**Wichtig:** Alle `StreamProvider`-Familien müssen primitive Typen als Parameter verwenden (int, String) — keine Objekte.

---

## 8. Navigation & Routing

### Route-Konstanten (`lib/core/navigation/routes.dart`)

```dart
Routes.onboarding      = '/onboarding'
Routes.home            = '/home'
Routes.training        = '/training'
Routes.activeWorkout   = '/training/active'
Routes.exerciseLibrary = '/training/exercises'
Routes.workoutDetail   = '/training/session/:id'
Routes.exerciseProgress= '/training/exercise/:id/progress'
Routes.health          = '/health'
Routes.nutrition       = '/nutrition'
Routes.mealLog         = '/nutrition/log'
Routes.foodSearch      = '/nutrition/search'
Routes.shoppingList    = '/nutrition/shopping'
Routes.supplements     = '/supplements'
Routes.planning        = '/planning'
Routes.medication      = '/medication'
Routes.abstinence      = '/abstinence'
Routes.budget          = '/budget'
Routes.transactionList = '/budget/transactions'
Routes.addTransaction  = '/budget/add'
Routes.budgetStats     = '/budget/stats'
Routes.savings         = '/budget/savings'
Routes.period          = '/period'
Routes.periodCalendar  = '/period/calendar'
Routes.cycleHistory    = '/period/history'
Routes.settings        = '/settings'
```

### GoRouter (`lib/core/navigation/router.dart`)

```dart
routerProvider = Provider<GoRouter>  // überwacht preferencesRepositoryProvider

Redirect-Logik:
  - !onboarded && !goingToOnboarding → Routes.onboarding
  - onboarded && goingToOnboarding   → Routes.home

Struktur:
  GoRoute(onboarding)          // außerhalb des Shells
  ShellRoute(TraumScaffold)    // alle anderen Screens
    ├── home
    ├── training (+ active, exercises, session/:id, exercise/:id/progress)
    ├── health
    ├── nutrition (+ shopping, log, search)
    ├── supplements
    ├── planning
    ├── medication
    ├── abstinence
    ├── budget (+ add, transactions, stats, savings)
    ├── period (+ calendar, history)
    └── settings
```

### TraumScaffold (`lib/core/navigation/traum_scaffold.dart`)

- Liest `navSlotsProvider` → 5 aktive Modul-Slots
- Bottom Navigation Bar mit den 5 ausgewählten Modulen
- "Mehr"-Button öffnet Modal Bottom Sheet mit allen restlichen Modulen
- Aktive Icons: CoralOrange, inaktive: onBackgroundMuted
- Obere Ecken: 20px Radius, Hintergrund: `bottomNav` (#12121F)
- 11 verfügbare Module: home, training, health, nutrition, planning, supplements, medication, abstinence, budget, period, settings

---

## 9. App-Start & Initialisierung

**Datei:** `lib/main.dart`

```
1. WidgetsFlutterBinding.ensureInitialized()
2. SharedPreferences.getInstance()
3. TraumDatabase()
4. Future.wait([
     WidgetDataService.init(),     // HomeWidget App Group setzen
     NotificationService.init(),   // Timezone + Channels initialisieren
   ])
5. Future.wait([
     ExerciseSeeder.seedIfNeeded(db),    // assets/exercises/*.json → DB
     SupplementSeeder.seedIfNeeded(db),  // assets/supplements/*.json → DB
     MedicationSeeder.seedIfNeeded(),
   ])
6. runApp(ProviderScope(
     overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
     child: TraumApp(),
   ))
```

**Datei:** `lib/app.dart`

```dart
class TraumApp extends ConsumerWidget {
  // MaterialApp.router mit:
  // - routerConfig: router (GoRouter)
  // - theme: TraumTheme.light
  // - darkTheme: TraumTheme.dark
  // - themeMode: ref.watch(themeProvider)
  // - locale: ref.watch(localeProvider)
  // - supportedLocales: AppLocalizations.supportedLocales
  // - localizationsDelegates: AppLocalizations.delegate + GlobalMaterial/Widgets/Cupertino
}
```

---

## 10. Onboarding

**Datei:** `lib/features/onboarding/onboarding_screen.dart`  
**Route:** `/onboarding` (außerhalb des Shells, kein BottomNav)

9 Seiten als PageView:
1. **Willkommen** — Logo, App-Name, Tagline
2. **Profil** — Name, Geburtstag (DatePicker), Biologisches Geschlecht (SegmentedButton: männlich/weiblich/divers), Einheiten (metrisch/imperial)
3. **Fitnessziele** — Schritte, Zielgewicht, Körpergröße
4. **Ernährungsziele** — Kalorien, Protein, Wasser
5. **Zykluseinrichtung** — nur wenn `userBiologicalSex == 'female'`, avgCycleLength + avgPeriodLength
6. **Navigation** — interaktiver 5-Slot-Selektor aus 11 Modulen
7. **Health Connect / HealthKit** — Permission-Request
8. **Benachrichtigungen** — Permission-Request
9. **Fertig** — setzt `onboarding_complete = true`, navigiert zu `/home`

Dot-Indikatoren unten, Weiter/Überspringen-Buttons.

---

## 11. Home-Screen

**Datei:** `lib/features/home/home_screen.dart`  
**Route:** `/home`

Scrollbarer Inhalt von oben nach unten:

| Element | Beschreibung |
|---------|-------------|
| TopBar | Personalisierter Gruß (Tageszeit), 52sp Uhr, Datum, Glocken-Icon, Einstellungen-Icon |
| Wetter-Karte | OpenMeteo API (lat/lon aus Prefs), gecacht |
| Termine | Horizontaler Scroll der heutigen Appointments |
| Aktivitäts-Grid | 2×2: Schritte (CircularProgressRing), Kalorien (GradientProgressBar), Protein (GradientProgressBar) |
| Wasser | Quick-Input-Karte: +200ml / +300ml / +500ml Buttons |
| Todos & Medikamente | 2-Spalten-Grid |
| Supplements | Schnellübersicht (bedingt) |
| Gewohnheiten | HabitWeekRow für alle Habits |
| Aktives Ziel | Bedingt wenn Ziel vorhanden |
| Abstinenz | Quick-View (bedingt) |
| Budget | Monatsübersicht-Karte |
| Periode | Bedingt wenn `isPeriodTrackingEnabled` |
| Gesundheits-Snapshot | Schlaf + Herzrate + Stimmung |

---

## 12. Modul: Training

| Screen | Route | Datei |
|--------|-------|-------|
| Übersicht | `/training` | `training_screen.dart` |
| Aktives Workout | `/training/active` | `active_workout_screen.dart` |
| Übungsbibliothek | `/training/exercises` | `exercise_library_screen.dart` |
| Session-Detail | `/training/session/:id` | `workout_detail_screen.dart` |
| Übungsfortschritt | `/training/exercise/:id/progress` | `exercise_progress_screen.dart` |

**training_screen.dart:**
- Aktive Trainingsplan-Chips
- Letztes Workout-Karte
- Fortschritts-Chart (TraumLineChart)
- Muskelgruppen-Tabs (8 Gruppen) mit Übungsscroll

**active_workout_screen.dart:**
- Set-Eingabe (Gewicht + Wiederholungen)
- Rest-Timer (CoralOrange Ring)
- Superset/Dropset-Unterstützung
- Workout-Zusammenfassung nach Abschluss

**exercise_library_screen.dart:**
- Muskelgruppen-Pill-Tabs
- Suchfeld
- Custom-Übung erstellen
- Übungen aus Seeder (assets/exercises/*.json)

**workout_detail_screen.dart:**
- `sessionId` als Parameter (via pathParameters)
- StreamBuilder auf `watchSession(sessionId)`
- Sets gruppiert nach exerciseId
- DataTable: Satz / Gewicht / Wdh.

**exercise_progress_screen.dart:**
- `exerciseId` als Parameter
- TraumLineChart: x = Session-Index, y = Max-Gewicht

---

## 13. Modul: Gesundheit (Health)

**Screen:** `/health` — `health_screen.dart`  
**4 Tabs:**

1. **Übersicht** — Schritte-Chart, Schlaf-Balkendiagramm, Herzrate-Linienchart
2. **Schlaf** — Einschlaf-/Aufwachzeit (TimePicker), Qualitätssterne 1–5, Dismissible-Listeneinträge
3. **Gewicht** — Eingabefeld + TraumLineChart mit Ziel-Linie (gestrichelt)
4. **Maße** — Körper-Silhouette (Canvas), Tap-to-Enter-Dialog für 9 Körpermaße

Health Connect (Android) / HealthKit (iOS) via `health` Package, graceful Fallback wenn Permissions fehlen.

---

## 14. Modul: Ernährung (Nutrition)

| Screen | Route | Datei |
|--------|-------|-------|
| Übersicht | `/nutrition` | `nutrition_screen.dart` |
| Mahlzeit-Log | `/nutrition/log` | `meal_log_screen.dart` |
| Lebensmittelsuche | `/nutrition/search` | `food_search_screen.dart` |
| Einkaufsliste | `/nutrition/shopping` | `shopping_list_screen.dart` |

**nutrition_screen.dart:**
- Tages-Makros: kcal + Protein + Kohlenhydrate (GradientProgressBars)
- Wasser-Ring (CircularProgressRing)
- Mahlzeiten gruppiert nach Typ (Frühstück/Mittag/Abend/Snacks)
- AddFood Bottom-Sheet

**meal_log_screen.dart:**
- Mahlzeit-Typ-Dropdown
- Lebensmittelname-Eingabe
- 4 Makro-Felder (kcal, Protein, Kohlenhydrate, Fett)
- Gespeicherte Templates zum Vorausfüllen

**food_search_screen.dart:**
- 15 hardcodierte Lebensmittel als Schnellauswahl
- Live-Filter-Suche
- `insertNutritionLog` bei Auswahl

**shopping_list_screen.dart:**
- Manuelle Einträge
- Kategorie-Gruppierung
- CheckBox-Abhaken

---

## 15. Modul: Supplements

**Screen:** `/supplements` — `supplement_screen.dart`

- Liste aller Supplements mit Name, Kategorie, Dosierung
- Toggle aktiv/inaktiv
- Add-Dialog: Name, Kategorie, Dosierung, Einheit
- Seeder: `assets/supplements/*.json` → 9 Kategorien

---

## 16. Modul: Planung (Planning)

**Screen:** `/planning` — `planning_screen.dart`  
**4 Tabs:**

1. **Kalender** — Monatsraster, Tagesauswahl, Termine anlegen, Wiederholungsregeln
2. **Todos** — Filter (Offen/Erledigt/Alle), Priorität, Fälligkeitsdatum, Archivieren
3. **Ziele** — Ziel + Teilaufgaben, Fortschrittsbalken
4. **Gewohnheiten** — 7-Tage-Raster (HabitWeekRow), Streak, Reminder

---

## 17. Modul: Medikamente (Medication)

**Screen:** `/medication` — `medication_screen.dart`

- Heutiger MedicationDotRow für schnellen Status-Überblick
- Vollständige Medikamentenliste
- Add-Dialog: Name, Dosierung, Form, Zeiten (JSON-Array)
- Benachrichtigungen über `NotificationService.scheduleDailyAt()`

---

## 18. Modul: Abstinenz (Abstinence)

**Screen:** `/abstinence` — `abstinence_screen.dart`

- Vertikale Liste von Tracker-Karten
- Live-Laufzeit über `Stream.periodic(Duration(seconds: 1))`
- Format: Tage / Stunden / Minuten / Sekunden
- Rückfall-Dialog mit Bestätigung
- Ereignishistorie (AbstinenceEvents)

---

## 19. Modul: Budget

| Screen | Route | Datei |
|--------|-------|-------|
| Übersicht | `/budget` | `budget_screen.dart` |
| Transaktion hinzufügen | `/budget/add` | `add_transaction_screen.dart` |
| Transaktionsliste | `/budget/transactions` | `transaction_list_screen.dart` |
| Statistiken | `/budget/stats` | `budget_stats_screen.dart` |
| Sparziele | `/budget/savings` | `savings_screen.dart` |

**budget_screen.dart:**
- Monatsnavigation (← Monat →)
- Balance-Karte (Einnahmen / Ausgaben / Saldo) mit Wellendekorator
- DonutChart nach Kategorien
- BudgetCategoryBar (Ausgaben vs. Limit) pro Kategorie
- Transaktionsliste mit Swipe-to-Delete

**transaction_list_screen.dart:**
- Monatsnavigation, Dismissible-Tiles

**budget_stats_screen.dart:**
- TraumLineChart über 6 Monate
- DataTable mit Monatszusammenfassung

**savings_screen.dart:**
- Sparziele mit LinearProgressIndicator
- Schulden-Tracker (Debts)
- Add-Dialoge für beides

---

## 20. Modul: Zyklustracking (Period)

**Nur sichtbar wenn `isPeriodTrackingEnabled == true`** (d.h. `userBiologicalSex == 'female'` oder manuell aktiviert)

| Screen | Route | Datei |
|--------|-------|-------|
| Übersicht | `/period` | `period_screen.dart` |
| Kalender | `/period/calendar` | `period_calendar_screen.dart` |
| Zyklushistorie | `/period/history` | `cycle_history_screen.dart` |

**cycle_calculator.dart** — Pure Dart (kein Flutter):
- `CycleCalculator.calculate({lastPeriodStart, avgCycleLength, avgPeriodLength})`
- Berechnet: `ovulationDate`, `fertileStart`, `fertileEnd`, `nextPeriodPredicted`, `pregnancyProbability`
- `daysUntilNextPeriod(DateTime predicted)`

**period_screen.dart:**
- Hero-Countdown-Karte (Gradient: periodRose → coralOrange): „X Tage bis zur nächsten Periode"
- InfoGrid: Eisprung-Datum + fruchtbares Fenster
- Symptom-Chips (6 voreingestellt): Krämpfe, Kopfschmerzen, Stimmungsschwankungen, Blähungen, Müdigkeit, Rückenschmerzen
- Einträge-Liste mit Delete
- FAB: „Periode starten" (DatePicker-Dialog)

**period_calendar_screen.dart:**
- Monatsnavigation
- 7-Spalten-Grid
- Farbcodierung: periodRose / ovulationCyan / fertileCyan / Prognose (periodRose @60%)
- Legende unten

**cycle_history_screen.dart:**
- Statistik-Block (Durchschnitt, Min, Max Zykluslänge)
- Zyklusliste
- TraumLineChart: Zykluslängen-Trend

---

## 21. Modul: Einstellungen (Settings)

**Screen:** `/settings` — `settings_screen.dart`  
Vertikal scrollbar, alle Abschnitte in ExpansionTiles/ListTiles:

| Abschnitt | Inhalt |
|-----------|--------|
| **Erscheinungsbild** | SegmentedButton: Dunkel / Hell / System |
| **Sprache** | SimpleDialog mit 9 Sprachen (Flagge + nativer Name) |
| **Einheiten** | SegmentedButton: Metrisch / Imperial (Gewicht, Länge, Temperatur) |
| **Benachrichtigungen** | 7 SwitchListTile (Medication, Supplement, Workout, Wasser, Gewohnheit, Todo, Periode) + Zeit-Picker; `rescheduleAll()` bei jedem Toggle |
| **Ziele** | Inline-Edit-Dialoge für Kalorien, Protein, Wasser, Schritte, Gewicht, Körpergröße |
| **Privatsphäre & Sicherheit** | Biometrie-Toggle (LocalAuthentication), JSON-Export (Share.shareXFiles), ZIP-Backup (ZipEncoder), Doppelt-bestätigen-Löschen (prefs.clearAll()) |
| **Wetter** | GPS-Button (Geolocator), manuelle Koordinaten-Eingabe |
| **Navigation** | ReorderableListView der 5 navSlots (jsonEncode beim Speichern) |
| **Zyklustracking** | Toggle `isPeriodTrackingEnabled` |
| **Währung** | Währungssymbol-Eingabe |
| **Widgets** | Wrap mit 11 Chips (Galerie aller Homescreen-Widgets) |
| **Version** | `PackageInfo.fromPlatform()` → `'1.0.0 (1)'` |
| **Onboarding** | Reset-Button |
| **Daten löschen** | Doppelt-bestätigen-Dialog → `prefs.clearAll()` |
| **Support** | „Fehler melden" → mailto-Link via url_launcher |

---

## 22. Benachrichtigungen

**Datei:** `lib/core/notifications/notification_service.dart`

### Initialisierung
```
init():
  1. tz_data.initializeTimeZones()
  2. FlutterTimezone.getLocalTimezone()
  3. tz.setLocalLocation(...)
  4. FlutterLocalNotificationsPlugin().initialize(
       AndroidInitializationSettings('@mipmap/ic_launcher'),
       DarwinInitializationSettings(),
     )
  5. Channels erstellen (Android)
```

### Android Notification Channels
| Channel-ID | Name | Beschreibung |
|-----------|------|-------------|
| `medication` | Medikamente | Erinnerungen für Medikamenteneinnahme |
| `supplement` | Supplements | Supplement-Erinnerungen |
| `workout` | Training | Workout-Erinnerungen |
| `water` | Wasser | Wasser-Trink-Erinnerungen |
| `habit` | Gewohnheiten | Gewohnheits-Check-ins |
| `todo` | Aufgaben | Fällige Todos |
| `period` | Zyklus | Periodenvorhersage |
| `budget` | Budget | Budget-Warnungen |

### Methoden
```dart
scheduleDailyAt({int id, String title, String body, int hour, int minute, String channelId})
  → zonedSchedule mit uiLocalNotificationDateInterpretation: absoluteTime

rescheduleAll(NotificationPrefsSnapshot prefs)
  → cancelAll() + alle aktivierten Channels neu planen

cancel(int id)
cancelAll()
```

**Datei:** `lib/core/notifications/notification_prefs.dart`  
→ Typisierter Wrapper für alle 16 Notification-Keys

### Background Workers (Kotlin, `android/…/workers/`)
| Worker | Aufgabe |
|--------|---------|
| `MedicationReminderWorker` | Medikamenten-Push |
| `SupplementReminderWorker` | Supplement-Push |
| `WorkoutReminderWorker` | Training-Push |
| `WaterReminderWorker` | Wasser-Push |
| `HabitReminderWorker` | Gewohnheits-Push |
| `TodoDueTodayWorker` | Todo-fällig-heute-Push |
| `PeriodReminderWorker` | Periodenvorhersage-Push |
| `BudgetAlertWorker` | Budget-Warnung-Push |

---

## 23. Homescreen-Widgets

**Datei:** `lib/widget/widget_data_service.dart`  
**App Group ID:** `group.de.traum.widgets`

### 24 Daten-Keys
```
steps, stepsGoal, calories, caloriesGoal,
waterMl, waterGoalMl, kcal, kcalGoal,
protein, proteinGoal, sleepHours, nextTodo,
abstinenceTitle, abstinenceDuration, periodDaysLabel,
budgetSpent, budgetLimit, habitsCompleted, habitsTotal,
medsTaken, medsTotal, nextAppointment, heartRate, mood
```

### 11 Widget-Klassen

| Name | Android Provider | iOS Name | Datei |
|------|-----------------|----------|-------|
| Übersicht | TraumOverviewWidgetProvider | TraumOverviewWidget | widget_overview.xml |
| Todo | TraumTodoWidgetProvider | TraumTodoWidget | widget_todo.xml |
| Schritte | TraumStepsWidgetProvider | TraumStepsWidget | widget_steps.xml |
| Abstinenz | TraumAbstinenceWidgetProvider | TraumAbstinenceWidget | widget_abstinence.xml |
| Periode | TraumPeriodWidgetProvider | TraumPeriodWidget | widget_period.xml |
| Gesundheit | TraumHealthWidgetProvider | TraumHealthWidget | widget_health.xml |
| Kalender | TraumCalendarWidgetProvider | TraumCalendarWidget | widget_calendar.xml |
| Budget | TraumBudgetWidgetProvider | TraumBudgetWidget | widget_budget.xml |
| Ernährung | TraumNutritionWidgetProvider | TraumNutritionWidget | widget_nutrition.xml |
| Gewohnheiten | TraumHabitsWidgetProvider | TraumHabitsWidget | widget_habits.xml |
| Medikamente | TraumMedicationWidgetProvider | TraumMedicationWidget | widget_medication.xml |

### Android (Kotlin)
- Alle 11 Klassen in `android/…/kotlin/de/traum/traum/Traum*WidgetProvider.kt`
- Erweitern `HomeWidgetProvider`
- Override: `onUpdate(context, appWidgetManager, appWidgetIds, widgetData)`
- Lesen aus widgetData Bundle, binden an RemoteViews
- `setProgressBar` für steps/budget (clamped 0–100)
- Update-Intervall: 30 Minuten

### iOS (SwiftUI / WidgetKit)
- **Datei:** `ios/TraumWidgets/TraumWidgets.swift`
- `@main struct TraumWidgetBundle: WidgetBundle` — alle 11 Widget-Typen
- Liest aus `UserDefaults(suiteName: "group.de.traum.widgets")`
- `StaticConfiguration` mit `TraumTimelineProvider` (30-min Refresh)
- `Color(hex:)` Extension für alle Farb-Konstanten

### iOS Konfiguration
- **`ios/Runner/Runner.entitlements`:**
  ```xml
  <key>com.apple.developer.healthkit</key><true/>
  <key>com.apple.security.application-groups</key>
  <array><string>group.de.traum.widgets</string></array>
  ```
- **`ios/Runner/Info.plist`:** AppGroupIdentifier = `group.de.traum.widgets`  
  ⚠️ WICHTIG: muss exakt `group.de.traum.widgets` sein (nicht `group.de.traum.traum`)

---

## 24. Lokalisierung (i18n)

**Konfiguration:** `l10n.yaml`  
**Generiert nach:** `lib/l10n/`

### Unterstützte Sprachen
| Code | Sprache | Datei |
|------|---------|-------|
| `de` | Deutsch (Template) | `app_de.arb` |
| `en` | Englisch | `app_en.arb` |
| `zh` | Chinesisch | `app_zh.arb` |
| `hi` | Hindi | `app_hi.arb` |
| `es` | Spanisch | `app_es.arb` |
| `fr` | Französisch | `app_fr.arb` |
| `ar` | Arabisch | `app_ar.arb` |
| `pt` | Portugiesisch | `app_pt.arb` |
| `ru` | Russisch | `app_ru.arb` |

Aktivierung: `setAppLocale(code)` in Settings → `localeProvider` aktualisiert sich → `MaterialApp.router` nimmt die neue Locale.

---

## 25. Core Components

**Barrel-Export:** `lib/core/components/components.dart`

| Komponente | Datei | Beschreibung |
|-----------|-------|-------------|
| `TraumCard` | `traum_card.dart` | Wrapper mit `surface`-Farbe, 20px Radius, optionaler Padding |
| `GradientButton` | `gradient_button.dart` | Pill-Button mit `gradientWarm` |
| `GradientProgressBar` | `gradient_progress_bar.dart` | Horizontaler Fortschrittsbalken mit Gradient |
| `CircularProgressRing` | `circular_progress_ring.dart` | CustomPainter Ring, Prozentwert-Label mittig |
| `AppointmentChip` | `appointment_chip.dart` | Kleiner Chip für Kalendertermine |
| `SectionHeader` | `section_header.dart` | Abschnittsüberschrift mit Trennlinie |
| `HabitWeekRow` | `habit_week_row.dart` | 7 Tage Mo–So mit Abhak-Indikator |
| `TraumLineChart` | `traum_line_chart.dart` | fl_chart LineChart, Gradient-Füllung unter Linie |
| `DonutChart` | `donut_chart.dart` | fl_chart PieChart als Donut |
| `BudgetCategoryBar` | `budget_category_bar.dart` | Horizontaler Bar: Ausgaben vs. Limit |
| `ShimmerLoader` | `shimmer_loader.dart` | Shimmer-Lade-Platzhalter |
| `MedicationDotRow` | `medication_dot_row.dart` | Farbige Dots für Einnahme-Zeiten |

### TraumLineChart (`traum_line_chart.dart`)
```dart
TraumLineChart({
  required List<FlSpot> spots,
  required List<String> xLabels,
  Color color = TraumColors.cyanBlue,
  LinearGradient? gradient,
  double? minY,
  double? maxY,
  double height = 120,
})
```
Kein Grid, kein Border, nur X-Achsen-Labels. Bereich unter Linie: `color.withValues(alpha: 0.3) → 0.0`  
⚠️ Immer `withValues(alpha: x)` verwenden, **nicht** `withOpacity(x)` (deprecated)

---

## 26. Android-Native (Kotlin)

**Package:** `de.traum.traum`  
**Dateipfad:** `android/app/src/main/kotlin/de/traum/traum/`

### MainActivity.kt
- Extends `FlutterActivity`

### Widget Provider (11 Dateien)
- Alle: `class Traum*WidgetProvider : HomeWidgetProvider()`
- Pattern: lesen aus `widgetData` Bundle → `RemoteViews(packageName, R.layout.widget_*)` → `setTextViewText`, `setProgressBar`

### Workers (8 Dateien, in `workers/`)
- Alle: `class *Worker(context: Context, params: WorkerParameters) : Worker(context, params)`
- Pattern: `NotificationCompat.Builder(context, channelId).build()` → `NotificationManagerCompat.notify()`

### Manifest-Einträge (AndroidManifest.xml)
- 11 `<receiver>` Blöcke für alle Widget-Provider
- Intent-Filter: `android.appwidget.action.APPWIDGET_UPDATE`
- Meta-Data: `android:resource="@xml/widget_*_info"`
- Permissions: INTERNET, RECEIVE_BOOT_COMPLETED, FOREGROUND_SERVICE, SCHEDULE_EXACT_ALARM, Health Connect queries

### Widget-Layouts (`res/layout/widget_*.xml`)
- Hintergrundfarbe: `#1A1A2E` (surface)
- Akzentfarbe: `#FF6B3D` (coralOrange)
- Größen in `res/xml/widget_*_info.xml`:
  - Übersicht/Gesundheit/Ernährung: 250×110dp
  - alle anderen: 180×110dp
  - updatePeriodMillis: 1800000 (30 min)

---

## 27. iOS-Native (Swift/WidgetKit)

**Datei:** `ios/TraumWidgets/TraumWidgets.swift`

```swift
@main struct TraumWidgetBundle: WidgetBundle {
  // 11 Widget-Typen als @WidgetBundleBuilder
}

// Jeder Widget-Typ:
struct Traum*Widget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "Traum*Widget", provider: TraumTimelineProvider()) {
      Traum*WidgetEntryView(entry: $0)
    }
  }
}

// Datenzugriff:
let defaults = UserDefaults(suiteName: "group.de.traum.widgets")
let value = defaults?.string(forKey: "keyName") ?? "—"

// Farb-Extension:
extension Color { init(hex: String) { … } }
// Farben: #FF6B3D, #1A1A2E, #00D4D4, #8888AA
```

---

## 28. Bekannte Architekturentscheidungen

1. **Kein Backend** — alle Daten sind lokal in SQLite (Drift) oder SharedPreferences
2. **Stream-first** — DAOs liefern `Stream<List<T>>`, Screens nutzen `StreamProvider` oder `StreamBuilder`
3. **Repository-Pattern** — DAOs werden von Repositories gewrappt; Screens kennen keine DAOs
4. **Providers sind read-only** — Mutation immer über `ref.read(xRepositoryProvider).method()`
5. **Drift Code-Gen** — nach Tabellen-Änderungen muss `flutter pub run build_runner build --delete-conflicting-outputs` ausgeführt werden
6. **Primitive StreamProvider-Parameter** — keine Objekte/Records als Family-Parameter (Riverpod-Einschränkung)
7. **Material 3** — `CardThemeData`, `DialogThemeData`, `TabBarThemeData` (keine Legacy-Namen)
8. **`withValues(alpha:)` statt `withOpacity()`** — `withOpacity` ist deprecated in Flutter 3.27+
9. **Benachrichtigungen brauchen Timezone** — `timezone` + `flutter_timezone` müssen vor `zonedSchedule` initialisiert sein
10. **iOS App Group** — muss überall `group.de.traum.widgets` sein (Runner.entitlements, Info.plist, Swift-Code, Dart-Code)
11. **`Share.shareXFiles()`** — nicht `SharePlus.instance.shareXFiles()` (falsche Klasse)
12. **`setNavSlots(jsonEncode(list))`** — der Key erwartet JSON-String, nicht `List<String>`

---

## 29. Wichtige Konventionen

### Import-Alias
```dart
import '../../core/utils/date_utils.dart' as traum_dates;
import 'cycle_calculator.dart' as cc;
```

### Seeder-Muster
```dart
static Future<void> seedIfNeeded(TraumDatabase db) async {
  final count = await db.xxx.select().get();
  if (count.isNotEmpty) return;
  // Assets laden und einfügen
}
```

### Dialog-Muster
```dart
showDialog(context: context, builder: (ctx) => AlertDialog(
  title: …,
  content: …,
  actions: [
    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Abbrechen')),
    TextButton(onPressed: () async {
      await repo.insert(…);
      if (ctx.mounted) Navigator.pop(ctx);
    }, child: const Text('Speichern')),
  ],
));
```

### Route-Navigation mit Parametern
```dart
// Navigieren zu:
context.push('/training/session/$sessionId');
context.push('/training/exercise/$exerciseId/progress');

// Parameter empfangen:
builder: (_, state) => WorkoutDetailScreen(
  sessionId: int.parse(state.pathParameters['id']!),
),
```

### Alle UI-Strings
- Alle sichtbaren Strings sind auf **Deutsch** — keine englischen Strings in der UI
- Formale Anrede vermeiden, direkte Sprache

### flutter analyze
- **Ziel: 0 Issues** — vor jedem Commit prüfen
- Keine `withOpacity()`, keine `unnecessary_brace_in_string_interps`, keine fehlenden `{}`
- `sort_child_properties_last`: `child:` immer als letztes Property

### Tests
- `flutter test` → 28 Tests, alle grün
- Unit-Tests: `cycle_calculator`, `calculateStreak`, Seeder
- Widget-Tests: `TraumCard`, `GradientProgressBar`, `CircularProgressRing`, `HabitWeekRow`

---

*Zuletzt aktualisiert: Commit `704469c` auf Branch `claude/new-session-y2Jyo`*
