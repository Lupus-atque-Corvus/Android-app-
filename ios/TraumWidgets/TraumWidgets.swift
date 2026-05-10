import WidgetKit
import SwiftUI

// MARK: - Shared data helpers

private let appGroup = "group.de.traum.widgets"

private func widgetString(_ key: String, default def: String = "—") -> String {
    UserDefaults(suiteName: appGroup)?.string(forKey: key) ?? def
}

private func widgetInt(_ key: String, default def: Int = 0) -> Int {
    UserDefaults(suiteName: appGroup)?.integer(forKey: key) ?? def
}

// MARK: - Simple timeline provider (refreshes every 30 min)

struct TraumTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> TraumEntry {
        TraumEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (TraumEntry) -> Void) {
        completion(TraumEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TraumEntry>) -> Void) {
        let entry = TraumEntry(date: Date())
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }
}

struct TraumEntry: TimelineEntry {
    let date: Date
}

// MARK: - Overview Widget

struct OverviewWidgetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("TRAUM")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            HStack {
                StatColumn(value: widgetString("steps", default: "0"), label: "Schritte")
                StatColumn(value: "\(widgetString("waterMl", default: "0")) ml", label: "Wasser", color: Color(hex: "#00D4D4"))
                StatColumn(value: widgetString("kcal", default: "0"), label: "kcal", color: Color(hex: "#FFAA55"))
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct OverviewWidget: Widget {
    let kind = "TraumOverviewWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            OverviewWidgetView()
        }
        .configurationDisplayName("TRAUM Übersicht")
        .description("Schritte, Wasser und Kalorien auf einen Blick.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Steps Widget

struct StepsWidgetView: View {
    private var steps: Int { Int(widgetString("steps", default: "0")) ?? 0 }
    private var goal: Int { Int(widgetString("stepsGoal", default: "10000")) ?? 10000 }
    private var progress: Double { goal > 0 ? min(Double(steps) / Double(goal), 1.0) : 0 }

    var body: some View {
        VStack(spacing: 6) {
            Text("\(steps)")
                .font(.title2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text("/ \(goal) Schritte")
                .font(.caption2)
                .foregroundColor(.secondary)
            ProgressView(value: progress)
                .tint(Color(hex: "#FF6B3D"))
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct StepsWidget: Widget {
    let kind = "TraumStepsWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            StepsWidgetView()
        }
        .configurationDisplayName("TRAUM Schritte")
        .description("Täglicher Schrittzähler.")
        .supportedFamilies([.systemSmall])
    }
}

// MARK: - Todo Widget

struct TodoWidgetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Nächste Aufgabe")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text(widgetString("nextTodo", default: "Keine offenen Aufgaben"))
                .font(.subheadline)
                .foregroundColor(.white)
                .lineLimit(3)
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct TodoWidget: Widget {
    let kind = "TraumTodoWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            TodoWidgetView()
        }
        .configurationDisplayName("TRAUM Todo")
        .description("Nächste fällige Aufgabe.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Abstinence Widget

struct AbstinenceWidgetView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text(widgetString("abstinenceTitle", default: "Abstinenz"))
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text(widgetString("abstinenceDuration", default: "—"))
                .font(.title3).bold()
                .foregroundColor(.white)
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct AbstinenceWidget: Widget {
    let kind = "TraumAbstinenceWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            AbstinenceWidgetView()
        }
        .configurationDisplayName("TRAUM Abstinenz")
        .description("Aktiver Abstinenz-Tracker.")
        .supportedFamilies([.systemSmall])
    }
}

// MARK: - Period Widget

struct PeriodWidgetView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("Nächste Periode")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text(widgetString("periodDaysLabel", default: "—"))
                .font(.title2).bold()
                .foregroundColor(.white)
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct PeriodWidget: Widget {
    let kind = "TraumPeriodWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            PeriodWidgetView()
        }
        .configurationDisplayName("TRAUM Zyklus")
        .description("Countdown zur nächsten Periode.")
        .supportedFamilies([.systemSmall])
    }
}

// MARK: - Health Widget

struct HealthWidgetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Gesundheit")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#00D4D4"))
            HStack {
                StatColumn(value: "\(widgetString("sleepHours", default: "0"))h", label: "Schlaf")
                StatColumn(value: "\(widgetString("heartRate", default: "—")) bpm", label: "HR", color: Color(hex: "#FF4466"))
                StatColumn(value: widgetString("mood", default: "—"), label: "Mood", color: Color(hex: "#FFAA55"))
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct HealthWidget: Widget {
    let kind = "TraumHealthWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            HealthWidgetView()
        }
        .configurationDisplayName("TRAUM Gesundheit")
        .description("Schlaf, Herzrate und Stimmung.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Calendar Widget

struct CalendarWidgetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Nächster Termin")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text(widgetString("nextAppointment", default: "Kein Termin"))
                .font(.subheadline)
                .foregroundColor(.white)
                .lineLimit(3)
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct CalendarWidget: Widget {
    let kind = "TraumCalendarWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            CalendarWidgetView()
        }
        .configurationDisplayName("TRAUM Kalender")
        .description("Nächster anstehender Termin.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Budget Widget

struct BudgetWidgetView: View {
    private var spent: Double { Double(widgetString("budgetSpent", default: "0.00")) ?? 0 }
    private var limit: Double { Double(widgetString("budgetLimit", default: "0.00")) ?? 0 }
    private var progress: Double { limit > 0 ? min(spent / limit, 1.0) : 0 }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Budget")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text(String(format: "%.2f €", spent))
                .font(.title3).bold()
                .foregroundColor(.white)
            Text(String(format: "von %.2f €", limit))
                .font(.caption2)
                .foregroundColor(.secondary)
            ProgressView(value: progress)
                .tint(Color(hex: "#FF6B3D"))
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct BudgetWidget: Widget {
    let kind = "TraumBudgetWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            BudgetWidgetView()
        }
        .configurationDisplayName("TRAUM Budget")
        .description("Monatliche Ausgaben und Budget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Nutrition Widget

struct NutritionWidgetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Ernährung")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FFAA55"))
            HStack {
                StatColumn(value: widgetString("kcal", default: "0"), label: "kcal", color: Color(hex: "#FFAA55"))
                StatColumn(value: "\(widgetString("protein", default: "0")) g", label: "Protein", color: Color(hex: "#00D4D4"))
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct NutritionWidget: Widget {
    let kind = "TraumNutritionWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            NutritionWidgetView()
        }
        .configurationDisplayName("TRAUM Ernährung")
        .description("Kalorien und Protein heute.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Habits Widget

struct HabitsWidgetView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("Gewohnheiten")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text("\(widgetString("habitsCompleted", default: "0")) / \(widgetString("habitsTotal", default: "0"))")
                .font(.title2).bold()
                .foregroundColor(.white)
            Text("heute erledigt")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct HabitsWidget: Widget {
    let kind = "TraumHabitsWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            HabitsWidgetView()
        }
        .configurationDisplayName("TRAUM Gewohnheiten")
        .description("Heutige Gewohnheiten-Fortschritt.")
        .supportedFamilies([.systemSmall])
    }
}

// MARK: - Medication Widget

struct MedicationWidgetView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("Medikamente")
                .font(.caption2).bold()
                .foregroundColor(Color(hex: "#FF6B3D"))
            Text("\(widgetString("medsTaken", default: "0")) / \(widgetString("medsTotal", default: "0"))")
                .font(.title2).bold()
                .foregroundColor(.white)
            Text("heute eingenommen")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#1A1A2E"))
    }
}

struct MedicationWidget: Widget {
    let kind = "TraumMedicationWidgetProvider"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TraumTimelineProvider()) { _ in
            MedicationWidgetView()
        }
        .configurationDisplayName("TRAUM Medikamente")
        .description("Einnahme-Fortschritt heute.")
        .supportedFamilies([.systemSmall])
    }
}

// MARK: - Widget Bundle

@main
struct TraumWidgetBundle: WidgetBundle {
    var body: some Widget {
        OverviewWidget()
        StepsWidget()
        TodoWidget()
        AbstinenceWidget()
        PeriodWidget()
        HealthWidget()
        CalendarWidget()
        BudgetWidget()
        NutritionWidget()
        HabitsWidget()
        MedicationWidget()
    }
}

// MARK: - Shared sub-views

private struct StatColumn: View {
    let value: String
    let label: String
    var color: Color = .white

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(value)
                .font(.subheadline).bold()
                .foregroundColor(color)
                .lineLimit(1)
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Color hex extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
