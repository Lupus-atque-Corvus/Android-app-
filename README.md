# TRAUM — Persönliches Life-Dashboard

> Alle Daten bleiben auf deinem Gerät. Keine Cloud. Keine Accounts. Keine Werbung.

TRAUM ist eine vollständige Flutter-App für Android und iOS, die alle wichtigen Lebensbereiche in einem einzigen, einheitlichen Dashboard vereint. Von Fitness über Ernährung bis hin zu Budget und Gesundheit — alles an einem Ort, vollständig offline, vollständig privat.

---

## Inhaltsverzeichnis

1. [Features im Überblick](#features-im-überblick)
2. [Module im Detail](#module-im-detail)
3. [Design & Benutzeroberfläche](#design--benutzeroberfläche)
4. [Technischer Aufbau](#technischer-aufbau)
5. [Datenbank & Datenschutz](#datenbank--datenschutz)
6. [Benachrichtigungen](#benachrichtigungen)
7. [Homescreen-Widgets](#homescreen-widgets)
8. [Einstellungen](#einstellungen)
9. [Lokalisierung](#lokalisierung)
10. [Projektstruktur](#projektstruktur)
11. [Entwicklung](#entwicklung)

---

## Features im Überblick

| Modul | Beschreibung |
|---|---|
| **Home** | Dashboard mit allen wichtigen Kennzahlen auf einen Blick |
| **Training** | Trainingsplanung, aktive Einheiten, Übungsbibliothek, Fortschrittscharts |
| **Gesundheit** | Schlaf, Gewicht, Körpermaße, Herzrate, Stimmung |
| **Ernährung** | Mahlzeitenprotokoll, Makros, Wasser, Einkaufsliste |
| **Planung** | Kalender, Todos, Ziele mit Unteraufgaben, Gewohnheiten |
| **Supplemente** | Supplement-Verwaltung, Zeitplanung, Protokoll |
| **Medikamente** | Medikamentenliste, Einnahmestatus, Benachrichtigungen |
| **Abstinenz** | Mehrere parallele Abstinenz-Tracker mit Live-Zeitmessung |
| **Budget** | Ausgaben, Einnahmen, Kategorien, Sparziele, Schulden |
| **Zyklus** | Periodenvorhersage, Eisprung, Fruchtbarkeitsfenster *(nur weiblich)* |
| **Einstellungen** | Theme, Sprache, Einheiten, Benachrichtigungen, Export, Sicherheit |

---

## Module im Detail

### Home-Dashboard

Das Home ist der zentrale Anlaufpunkt der App. Es zeigt eine personalisierte Begrüßung, die aktuelle Uhrzeit und ein scrollbares Dashboard mit allen wichtigen Kennzahlen des Tages:

- **Wetter-Karte** — aktuelle Wetterdaten via Open-Meteo API (GPS oder manuelle Koordinaten)
- **Termine** — horizontal scrollbare Ansicht der heutigen Termine
- **Aktivitäts-Grid** — Schrittzähler (Ring), Kalorien und Protein als Fortschrittsbalken
- **Wasser-Karte** — Schnell-Input mit +200 ml / +300 ml / +500 ml Buttons
- **Todo & Medikamente** — 2-spaltiges Grid mit heutigen Aufgaben und Einnahme-Status
- **Gewohnheiten** — 7-Tage-Rückblick mit farbigen Checkboxen
- **Budget-Übersicht** — Ausgaben vs. Limit des laufenden Monats
- **Gesundheits-Snapshot** — Schlaf, Herzrate, Stimmung
- **Periode-Karte** — Countdown bis zur nächsten Periode *(nur wenn aktiviert)*

Die unteren 5 Navigationslots sind frei konfigurierbar — jeder Nutzer legt fest, welche Module direkt erreichbar sind.

---

### Training

**Trainingsplanung**
- Erstellung und Verwaltung von Trainingsplänen mit Trainingstagen
- Zuweisung von Übungen pro Tag (Muskelgruppe, Gerät, Anweisungen)

**Aktive Trainingseinheit**
- Live-Timer für die Einheitendauer
- 90-Sekunden Pausentimer als animierter Fortschrittsring
- Eingabe von Sätzen (Gewicht in kg + Wiederholungen)
- Unterstützung für Supersätze und Dropsätze
- Automatische Speicherung der Session beim Beenden

**Übungsbibliothek**
- Über 60 vorgefertigte Übungen in 9 Muskelgruppen:
  - Brust, Rücken, Schultern, Bizeps, Trizeps, Beine, Core, Cardio, Ganzkörper
- Suchfunktion und Filter nach Muskelgruppe
- Eigene Übungen erstellen

**Fortschritt**
- Detailansicht jeder vergangenen Trainingseinheit
- Per-Übung Fortschrittschart (maximales Gewicht über Zeit)

---

### Gesundheit

**Übersicht**
- Schritte-Liniendiagramm (via Health Connect / HealthKit)
- Schlafbalkendiagramm der letzten 7 Tage
- Herzrate-Liniendiagramm

**Schlaf**
- Manuelle Eingabe von Schlafzeiten (Zeitwähler)
- Schlafqualität mit Sterne-Bewertung (1–5)
- Protokollliste aller Einträge

**Gewicht**
- Eingabe des aktuellen Gewichts (kg oder lbs)
- Liniendiagramm mit optionaler Ziel-Linie (gestrichelt)
- Vollständige Gewichtsverlaufsliste

**Körpermaße**
- Interaktive Körpersilhouette — Antippen öffnet Eingabedialog
- Maßnahmen: Brust, Taille, Hüfte, Bizeps, Oberschenkel, Wade, Schultern, Unterarm

---

### Ernährung

- **Tages-Makros** — Fortschrittsbalken für Kalorien, Protein, Kohlenhydrate, Fett
- **Wasser-Ring** — Kreisfortschritt + Schnell-Chips (+200/300/500/750 ml)
- **Mahlzeitenprotokoll** — getrennt nach Frühstück, Mittagessen, Abendessen, Snacks
- **Mahlzeit erfassen** — Formular mit Makroeingabe, gespeicherte Vorlagen zur Schnellauswahl
- **Lebensmittelsuche** — lokale Datenbank mit 15 gängigen Lebensmitteln inkl. Makros
- **Einkaufsliste** — Abhaken, Wischen zum Löschen, manuelle Einträge

---

### Planung

**Kalender**
- Monatsansicht mit farbigen Termin-Chips
- Tagesdetail mit allen Terminen
- Wiederkehrende Termine (täglich / wöchentlich / monatlich)

**Todos**
- Filter nach Priorität (Hoch / Mittel / Niedrig) und Status
- Wischen zum Erledigen / Löschen
- Fälligkeitsdatum-Benachrichtigungen

**Ziele**
- Ziele mit Unteraufgaben
- Fortschrittsbalken basierend auf erledigten Unteraufgaben

**Gewohnheiten**
- 7-Tage-Grid — antippen zum Ein-/Austragen
- Streak-Anzeige (aktuelle Tages-Strähne)
- Motivations-Emojis im 7-Tage-Rückblick

---

### Supplemente

- Liste aller eingetragenen Supplemente (Name, Kategorie, Menge, Einheit)
- Aktiv/Inaktiv-Toggle pro Supplement
- Einnahme-Zeitplanung (Morgen / Mittag / Abend / Vor dem Training / Nach dem Training)
- Tagesprotokoll mit Zeitstempeln
- Vorbefüllt mit über 50 Supplementen aus 9 Kategorien:
  - Vitamine, Mineralien, Aminosäuren, Protein, Omega, Adaptogene, Pre-Workout, Darmgesundheit, Kreatin

---

### Medikamente

- Medikamentenliste mit Dosierung und Zeitplanung
- Tagesansicht: Einnahme-Dots (ausgefüllt = genommen, leer = ausstehend)
- Antippen zum Markieren als eingenommen / nicht eingenommen
- Compliance-Kalender (Einnahme-Übersicht der vergangenen Wochen)
- Tägliche Push-Benachrichtigungen zur Erinnerung

---

### Abstinenz

- Beliebig viele parallele Abstinenz-Tracker (z. B. Alkohol, Rauchen, Social Media)
- Live-Zeitmessung: Tage, Stunden, Minuten, Sekunden — aktualisiert sich sekündlich
- Rückfall-Dialog setzt den Timer zurück und protokolliert das Ereignis
- Ereignis-Verlauf pro Tracker (Rückfälle mit Datum)
- Eigene Bezeichnung und Emoji pro Tracker

---

### Budget

**Monatsübersicht**
- Monatsnavigation (← →)
- Einnahmen vs. Ausgaben-Saldo mit Wellendekoration
- Donut-Diagramm der Ausgaben nach Kategorien
- Fortschrittsbalken pro Kategorie vs. Limit

**Transaktionen**
- Vollständige Liste aller Transaktionen mit Monatsfilter
- Wischen zum Löschen
- Unterscheidung: Ausgabe (rot ↓) / Einnahme (grün ↑)

**Transaktion hinzufügen**
- Typ-Wahl (Ausgabe / Einnahme)
- Beschreibung, Betrag, Kategorie, Datum

**Statistik**
- 6-Monats-Ausgabentrend als Liniendiagramm
- Monatsdetails als Tabelle

**Sparziele & Schulden**
- Sparziele mit Fortschrittsbalken (aktuell / Ziel)
- Schuldenverwaltung mit Gläubiger und Betrag

---

### Zyklus *(nur für weibliche Nutzer)*

Die gesamte Zykluslogik ist als reines Dart-Modul implementiert (`cycle_calculator.dart`) — ohne externe Abhängigkeiten.

**Berechnungen:**
- Eisprung = Letzter Periodenstart + (Zykluslänge − 14 Tage)
- Fruchtbarkeitsfenster = Eisprung − 5 Tage bis Eisprung + 1 Tag
- Nächste Periode = Letzter Periodenstart + Zykluslänge
- Schwangerschaftswahrscheinlichkeit: 0 % außerhalb des Fensters, linear ansteigend innerhalb

**Screens:**
- **Periode** — Countdown-Hero-Karte, Symptom-Chips (Krämpfe, Kopfschmerz, Stimmung, ...), Eintrags-Liste
- **Kalender** — Monatsraster mit farblicher Kennzeichnung:
  - Periodenrosa = aktive Periode
  - Cyan = Eisprung
  - Cyan (transparent) = Fruchtbarkeitsfenster
  - Rosa (transparent) = Prognose
- **Verlauf** — Zykluslängen-Statistik, Trenddiagramm, vollständige Eintrags-Liste

---

## Design & Benutzeroberfläche

TRAUM verwendet ein konsequentes Dark-First-Design:

| Element | Wert |
|---|---|
| Hintergrund | `#0D0D1A` |
| Oberfläche (Cards) | `#1A1A2E` |
| Oberfläche Variante | `#22223A` |
| Akzent Warm — CoralOrange | `#FF6B3D` |
| Akzent Warm — PeachOrange | `#FFAA55` |
| Akzent Kalt — CyanBlue | `#00D4D4` |
| Akzent Kalt — TurquoisBlue | `#0099BB` |
| Erfolg | `#2DD4BF` |
| Warnung | `#FFB347` |
| Fehler | `#FF4466` |
| Schrift | DM Sans (Google Fonts) |
| Card-Radius | 20 px |
| Button-Radius | 50 px (Pill) |
| Bottom-Nav | `#12121F`, obere Ecken 20 px gerundet |

**Konfigurierbare Navigation:** Die 5 Slots der unteren Navigationsleiste sind per Drag & Drop in den Einstellungen frei sortierbar. Alle weiteren Module sind über ein "Mehr"-Menü erreichbar.

---

## Technischer Aufbau

### Tech Stack

| Bereich | Technologie |
|---|---|
| Framework | Flutter (Android + iOS) |
| Sprache | Dart |
| State Management | Riverpod 2.x (`Provider`, `StreamProvider`, `NotifierProvider`) |
| Navigation | GoRouter 14 mit `ShellRoute` |
| Datenbank | Drift 2.20 (SQLite, Code-generiert) |
| Einstellungen | SharedPreferences + Flutter Secure Storage |
| Gesundheitsdaten | health (Health Connect / HealthKit) |
| Charts | fl_chart |
| Benachrichtigungen | flutter_local_notifications + WorkManager |
| Homescreen-Widgets | home_widget |
| Biometrie | local_auth (Face ID / Fingerabdruck) |
| Standort | geolocator |
| Export | share_plus + archive |
| Zeitplanung | timezone + flutter_timezone |
| Schrift | google_fonts (DM Sans) |
| Kamera / Fotos | image_picker |
| HTTP | http |
| Links | url_launcher |
| i18n | flutter_localizations + intl (ARB) |

### Mindest-Anforderungen

| Platform | Mindestversion |
|---|---|
| Android | SDK 26 (Android 8.0) |
| iOS | 16.0 |

---

## Datenbank & Datenschutz

Alle Daten werden **ausschließlich lokal** auf dem Gerät gespeichert. Es gibt keine Server, keine Cloud-Synchronisation, keine Nutzerkonten.

### Datenbankschema — 33 Tabellen

**Planung**
- `Appointments` — Termine (Titel, Datum, Uhrzeit, Wiederholung, Ort)
- `Todos` — Aufgaben (Titel, Priorität, Fälligkeit, Status)
- `Goals` — Ziele (Titel, Beschreibung, Frist, Fortschritt)
- `SubTasks` — Unteraufgaben zu Zielen
- `Habits` — Gewohnheiten (Name, Emoji, Ziel-Tage)
- `HabitLogs` — tägliche Einträge pro Gewohnheit

**Training**
- `WorkoutPlans` — Trainingspläne
- `WorkoutDays` — Trainingstage pro Plan
- `Exercises` — Übungen (Name, Muskelgruppe, Gerät, Anleitung)
- `WorkoutSessions` — protokollierte Einheiten (Datum, Dauer)
- `WorkoutSets` — einzelne Sätze (Übung, Gewicht, Wiederholungen)

**Gesundheit**
- `WeightLogs` — Gewichtseinträge (Datum, kg)
- `BodyMeasurements` — Körpermaße (12 Messpunkte)
- `SleepLogs` — Schlafeinträge (Start, Ende, Qualität)
- `MoodLogs` — Stimmungseinträge (Datum, Wert, Notiz)
- `PhotoLogs` — Fortschrittsfotos (Pfad, Datum)

**Ernährung**
- `NutritionLogs` — Mahlzeiteneinträge (Typ, Kalorien, Makros, Datum)
- `MealTemplates` — gespeicherte Mahlzeit-Vorlagen
- `WaterLogs` — Wassereinträge (ml, Datum)
- `ShoppingListItems` — Einkaufsliste (Name, Menge, erledigt)

**Supplemente**
- `Supplements` — Supplement-Definition (Name, Kategorie, Menge)
- `SupplementLogs` — Einnahmeprotokoll

**Medikamente**
- `Medications` — Medikament-Definition (Name, Dosierung, Zeiten)
- `MedicationLogs` — Einnahmeprotokoll mit Zeitstempel

**Abstinenz**
- `AbstinenceTrackers` — Tracker (Name, Emoji, Startdatum)
- `AbstinenceEvents` — Ereignisse (Rückfall, Neustart)

**Budget**
- `Transactions` — Buchungen (Betrag, Typ, Kategorie, Datum)
- `BudgetCategories` — Kategorien (Name, Limit, Farbe)
- `SavingsGoals` — Sparziele (Ziel, aktueller Stand)
- `Debts` — Schulden (Gläubiger, Betrag, Fälligkeit)

**Zyklus**
- `PeriodEntries` — Periodeneinträge (Start, Ende)
- `CycleCalculations` — berechnete Zyklusdaten
- `PeriodSymptoms` — Symptomprotokoll (Datum, Symptom, Intensität)

### Datenschutz-Funktionen

- **Biometrische Sperre** — Face ID / Fingerabdruck-Entsperrung beim App-Start
- **JSON-Export** — alle Daten als maschinenlesbarer Export
- **ZIP-Backup** — komprimiertes Backup zum Teilen / Archivieren
- **Daten löschen** — doppelt bestätigtes vollständiges Zurücksetzen aller Daten

---

## Benachrichtigungen

TRAUM verfügt über 8 separate Benachrichtigungs-Kanäle:

| Kanal | Zweck | Standard |
|---|---|---|
| Medikamenten-Erinnerung | Tägliche Medikamenteneinnahme | 08:00 Uhr |
| Supplement-Erinnerung | Tägliche Supplementeinnahme | 09:00 Uhr |
| Training-Erinnerung | Geplante Trainingseinheit | 18:00 Uhr |
| Wasser-Erinnerung | Regelmäßige Trink-Erinnerung | alle 90 min |
| Gewohnheiten | Abend-Check-in | 20:00 Uhr |
| Todo-Fälligkeiten | Aufgaben für heute | 07:00 Uhr |
| Zykluserinnerungen | Periode in X Tagen | 3 Tage vorher |
| Budget-Warnung | Budget fast ausgeschöpft | bei 90 % |

Alle Kanäle sind einzeln ein- und ausschaltbar. Änderungen werden sofort wirksam (`rescheduleAll()` wird bei jedem Toggle aufgerufen).

**WorkManager-Worker** laufen im Hintergrund:
`MedicationReminderWorker`, `SupplementReminderWorker`, `WorkoutReminderWorker`, `WaterReminderWorker`, `HabitReminderWorker`, `TodoDueTodayWorker`, `PeriodReminderWorker`, `BudgetAlertWorker`

---

## Homescreen-Widgets

TRAUM bietet 11 native Homescreen-Widgets für Android (AppWidgetProvider) und iOS (WidgetKit / SwiftUI):

| Widget | Inhalt | Größe |
|---|---|---|
| **Übersicht** | Schritte + Wasser + Kalorien | Mittel |
| **Schritte** | Schrittzähler mit Fortschrittsbalken | Klein |
| **Todo** | Nächste offene Aufgabe | Klein / Mittel |
| **Abstinenz** | Tracker-Name + vergangene Zeit | Klein |
| **Periode** | Countdown in Tagen | Klein |
| **Gesundheit** | Schlaf + Herzrate + Stimmung | Mittel |
| **Kalender** | Nächster anstehender Termin | Klein / Mittel |
| **Budget** | Ausgaben vs. Limit + Fortschrittsbalken | Klein / Mittel |
| **Ernährung** | Kalorien + Protein | Klein / Mittel |
| **Gewohnheiten** | Erledigte / Gesamt heute | Klein |
| **Medikamente** | Eingenommen / Gesamt heute | Klein |

Die Widgets lesen ihre Daten aus dem App-Group-Container (`group.de.traum.widgets`) und aktualisieren sich alle 30 Minuten automatisch.

**Hinzufügen:** Homescreen gedrückt halten → Widget → TRAUM → gewünschtes Widget auswählen.

---

## Einstellungen

### Erscheinungsbild
- Design: Dunkel / Hell / Systemstandard (gespeichert zwischen App-Starts)

### Sprache
- 9 Sprachen: Deutsch, English, 中文, हिंदी, Español, Français, العربية, Português, Русский
- Systemsprache wird standardmäßig erkannt

### Einheiten
- Metrisch (kg, cm, °C) oder Imperial (lbs, ft/in, °F)

### Benachrichtigungen
- 7 unabhängig schaltbare Kanäle mit sofortiger Neuplanung

### Datenschutz & Sicherheit
- Biometrische Sperre (Face ID / Fingerabdruck)
- Datenexport als JSON
- Backup als ZIP-Datei
- Alle Daten löschen (doppelte Bestätigung erforderlich)

### Wetter
- GPS-Standort automatisch ermitteln
- Koordinaten manuell eingeben (Breitengrad + Längengrad)

### Navigation
- Drag & Drop der 5 unteren Navigations-Slots
- Wahl aus: Start, Training, Gesundheit, Ernährung, Planung, Supplemente, Medikamente, Abstinenz, Budget, Zyklus

### Ziele
- Schritte/Tag, Tägliches Wasserziel, Kalorienziel — alle inline editierbar

### Konto
- App-Version anzeigen
- Onboarding zurücksetzen (startet Einrichtungsassistent neu)
- Fehler melden (öffnet E-Mail-Client mit vorausgefüllter Vorlage)
- Zyklusanalyse ein- / ausschalten

---

## Lokalisierung

Alle sichtbaren Strings sind über ARB-Dateien lokalisiert:

```
lib/l10n/
├── app_de.arb   ← Vorlage (Deutsch)
├── app_en.arb
├── app_zh.arb
├── app_hi.arb
├── app_es.arb
├── app_fr.arb
├── app_ar.arb
├── app_pt.arb
└── app_ru.arb
```

Die Sprachauswahl ist zur Laufzeit änderbar — die App reagiert sofort ohne Neustart.

---

## Projektstruktur

```
lib/
├── app.dart                        # MaterialApp.router, Theme, Locale
├── main.dart                       # Einstiegspunkt, Init-Sequenz
│
├── core/
│   ├── components/                 # Wiederverwendbare Widgets
│   │   ├── traum_card.dart
│   │   ├── gradient_button.dart
│   │   ├── gradient_progress_bar.dart
│   │   ├── circular_progress_ring.dart
│   │   ├── traum_line_chart.dart
│   │   ├── donut_chart.dart
│   │   ├── habit_week_row.dart
│   │   ├── medication_dot_row.dart
│   │   ├── appointment_chip.dart
│   │   ├── budget_category_bar.dart
│   │   ├── section_header.dart
│   │   └── shimmer_loader.dart
│   │
│   ├── navigation/
│   │   ├── router.dart             # GoRouter (alle Routen)
│   │   ├── routes.dart             # Pfad-Konstanten
│   │   └── traum_scaffold.dart     # Shell mit dynamischer BottomNav
│   │
│   ├── notifications/
│   │   ├── notification_service.dart  # Kanäle, scheduleDailyAt, rescheduleAll
│   │   └── notification_prefs.dart    # Typed Wrapper für Benachrichtigungs-Keys
│   │
│   ├── providers/
│   │   ├── preferences_provider.dart  # Theme, Locale, User-Daten, NavSlots
│   │   ├── repository_providers.dart  # 9 Repository-Provider
│   │   └── database_provider.dart     # TraumDatabase-Provider
│   │
│   ├── theme/
│   │   ├── colors.dart             # TraumColors (alle Farbkonstanten)
│   │   ├── radius.dart             # TraumRadius
│   │   ├── typography.dart         # DM Sans TextTheme
│   │   └── traum_theme.dart        # ThemeData dark + light
│   │
│   └── utils/
│       ├── formatters.dart         # formatCurrency, formatDuration, formatMl, formatWeight
│       ├── streak.dart             # calculateStreak()
│       └── date_utils.dart         # Grußtext, Datumsformatierung
│
├── data/
│   ├── database/
│   │   ├── tables/                 # 33 Drift-Tabellen (9 Dateien)
│   │   ├── daos/                   # 9 DAOs mit generierten .g.dart-Dateien
│   │   └── traum_database.dart     # @DriftDatabase (Haupt-DB-Klasse)
│   │
│   ├── preferences/
│   │   └── preferences_repository.dart  # SharedPreferences-Wrapper
│   │
│   └── repositories/               # 9 Repository-Klassen + 3 Seeder
│
├── features/
│   ├── home/                       # Dashboard
│   ├── onboarding/                 # 9-seitiger Einrichtungsassistent
│   ├── training/                   # 5 Screens
│   ├── health/                     # 4 Tabs
│   ├── nutrition/                  # 4 Screens
│   ├── planning/                   # 4 Tabs
│   ├── supplements/
│   ├── medication/
│   ├── abstinence/
│   ├── budget/                     # 5 Screens
│   ├── period_tracking/            # 3 Screens + CycleCalculator
│   └── settings/
│
├── l10n/                           # Generierte ARB-Klassen
└── widget/
    └── widget_data_service.dart    # HomeWidget Datensynchronisation

android/
├── app/src/main/
│   ├── kotlin/de/traum/traum/
│   │   ├── MainActivity.kt
│   │   ├── Traum*WidgetProvider.kt  # 11 AppWidgetProvider-Klassen
│   │   └── workers/                 # 8 WorkManager-Worker
│   ├── res/
│   │   ├── layout/                  # 11 Widget-XML-Layouts
│   │   └── xml/                     # 11 appwidget-provider XMLs
│   └── AndroidManifest.xml
└── app/proguard-rules.pro

ios/
├── Runner/
│   ├── Info.plist                   # NSUsageDescription Keys
│   └── Runner.entitlements          # HealthKit + App Group
└── TraumWidgets/
    └── TraumWidgets.swift           # WidgetKit Bundle (11 Widgets)

test/
├── cycle_calculator_test.dart       # 8 Tests
├── streak_test.dart                 # 7 Tests
├── formatters_test.dart             # 12 Tests
└── widget_test.dart
```

---

## Entwicklung

### Voraussetzungen

- Flutter 3.32+
- Dart 3.8+
- Android Studio / Xcode für Platform-Builds

### Setup

```bash
# Abhängigkeiten installieren
flutter pub get

# Code generieren (Drift + Riverpod)
dart run build_runner build --delete-conflicting-outputs

# App starten
flutter run

# Tests ausführen
flutter test

# Statische Analyse
flutter analyze
```

### Branch

Aktuelle Entwicklung: `claude/new-session-y2Jyo`

### Build

```bash
# Android Release APK
flutter build apk --release

# Android App Bundle (für Play Store)
flutter build appbundle --release

# iOS (ohne Codesigning)
flutter build ios --release --no-codesign
```

### Qualitätszustand

| Metrik | Status |
|---|---|
| `flutter analyze` | 0 Fehler, 0 Warnungen |
| Unit Tests | 28 / 28 bestanden |
| Unterstützte Plattformen | Android (SDK 26+), iOS (16.0+) |

---

## Lizenz

Privates Projekt — alle Rechte vorbehalten.
