//
//  EHMWidget.swift
//  EHMWidget
//
//  Created by Gianlo Personal on 17.01.2025.
//

import WidgetKit
import SwiftUI

struct EHMDailyHoursWidgetView: View {
    @Environment(\.widgetFamily) var family
    let entry: EHMWidgetEntry

    var body: some View {
        switch family {
        case .accessoryRectangular:
            RectangularWidgetView(entry: entry)
        case .accessoryCircular:
            CircularWidgetView(entry: entry)
        case .accessoryInline:
            InlineWidgetView(entry: entry)
        default:
            HomeScreenWidgetView(entry: entry)
        }
    }
}

// MARK: - Utility Methods
extension EHMWidgetEntry {
    func determineMessage(for todayHours: Double, averageHours: Double) -> (emoji: String, text: String) {
        if isWeekend() {
            return ("🎉", "Enjoy your weekend!")
        }

        switch todayHours {
        case 0:
            return ("🌅", "Start logging your hours!")
        case 0..<averageHours / 2:
            return ("🚀", "Good start, keep it up!")
        case averageHours / 2..<averageHours:
            return ("👏", "Nice progress, almost there!")
        case (averageHours - 0.1)..<(averageHours + 0.3):
            return ("🥳", "Goal reached! Well done!")
        default:
            return ("🔥", "Crushing it! You passed today's goal.")
        }
    }

    func isWeekend() -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        return weekday == 1 || weekday == 7 // 1 = Sunday, 7 = Saturday
    }
    
    
    /// Returns total hours booked for **today**.
    func totalHoursToday() -> Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return self.groupedTimeEntries
            .filter { calendar.isDate($0.date, inSameDayAs: today) }
            .reduce(0) { $0 + $1.value }
    }
    
}

// MARK: - Home Screen Widget
struct HomeScreenWidgetView: View {
    let entry: EHMWidgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            let todayHours = entry.totalHoursToday()
            let (emoji, textMessage) = entry.determineMessage(for: todayHours, averageHours: entry.averageHoursPerDay)

            // Top row with emoji and hours
            HStack {
                Text(emoji)
                    .font(.headline)
                Spacer()
                if todayHours > 0 {
                    Text("\(todayHours, specifier: "%.1f")H")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }

            Text(textMessage)
                .font(.title2.bold())
                .fixedSize(horizontal: false, vertical: true)
        }
        .containerBackground(for: .widget) {
            Color(.systemBackground)
        }
    }
}

// MARK: - Lock Screen Rectangular Widget
struct RectangularWidgetView: View {
    let entry: EHMWidgetEntry
    
    var body: some View {
        HStack {
            let todayHours = entry.totalHoursToday()
        
            if todayHours > 0 {
                Text("\(todayHours, specifier: "%.1f")H")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .containerBackground(for: .widget) {
            Color(.systemBackground)
        }
    }
}

// MARK: - Lock Screen Circular Widget
struct CircularWidgetView: View {
    let entry: EHMWidgetEntry
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])

    var body: some View {
        let todayHours = entry.totalHoursToday()

        ZStack {
            Gauge(value: todayHours, in: 0...entry.averageHoursPerDay) {
                Text("") // Accessible label (can be empty if not needed)
            }
            .gaugeStyle(.accessoryCircular)

            // Overlay the hours as text in the center
            Text("\(todayHours, specifier: "%.1f")H")
                .font(.caption)
        }
        .containerBackground(for: .widget) {
            Color(.systemBackground)
        }
    }
}

// MARK: - Lock Screen Inline Widget
struct InlineWidgetView: View {
    let entry: EHMWidgetEntry

    var body: some View {
        let todayHours = entry.totalHoursToday()
        let (emoji, textMessage) = entry.determineMessage(for: todayHours, averageHours: entry.averageHoursPerDay)

        HStack {
            
            Text("\(emoji) \(textMessage)")
                .font(.title2.bold())
                .fixedSize(horizontal: false, vertical: true)
        }
        .containerBackground(for: .widget) {
            Color(.systemBackground)
        }
    }
}

// MARK: - Widget Definition
struct EHMDailyHoursWidget: Widget {
    let kind: String = "EHMDayliHoursWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetProvider()) { entry in
            EHMDailyHoursWidgetView(entry: entry)
        }
        .configurationDisplayName("EHM Daily Hours")
        .description("Displays how many hours were booked today, plus motivational feedback.")
        .supportedFamilies([.systemSmall, .accessoryRectangular, .accessoryCircular, .accessoryInline])
    }
}

// MARK: - Preview
struct EHMDailyHoursWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EHMDailyHoursWidgetView(
                entry: EHMWidgetEntry(
                    date: Date(),
                    groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(totalHours: 0),
                    averageHoursPerDay: 8,
                    workingDaysLeft: 5,
                    monthHours: 160
                )
            )
            .previewDisplayName("No Hours Logged")
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            EHMDailyHoursWidgetView(
                entry: EHMWidgetEntry(
                    date: Date(),
                    groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(totalHours: 4),
                    averageHoursPerDay: 8,
                    workingDaysLeft: 5,
                    monthHours: 160
                )
            )
            .previewDisplayName("Half Daily Goal")
            .previewContext(WidgetPreviewContext(family: .systemSmall))

            EHMDailyHoursWidgetView(
                entry: EHMWidgetEntry(
                    date: Date(),
                    groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(totalHours: 8),
                    averageHoursPerDay: 8,
                    workingDaysLeft: 5,
                    monthHours: 160
                )
            )
            .previewDisplayName("Goal Reached")
            .previewContext(WidgetPreviewContext(family: .systemSmall))

            EHMDailyHoursWidgetView(
                entry: EHMWidgetEntry(
                    date: Date(),
                    groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(totalHours: 10),
                    averageHoursPerDay: 8,
                    workingDaysLeft: 5,
                    monthHours: 160
                )
            )
            .previewDisplayName("Exceeding Daily Goal")
            .previewContext(WidgetPreviewContext(family: .systemSmall))

            EHMDailyHoursWidgetView(
                entry: EHMWidgetEntry(
                    date: Date(),
                    groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(totalHours: 4),
                    averageHoursPerDay: 8,
                    workingDaysLeft: 5,
                    monthHours: 160
                )
            )
            .previewDisplayName("Half Daily Goal - Acessory")
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))

            EHMDailyHoursWidgetView(
                entry: EHMWidgetEntry(
                    date: Date(),
                    groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(totalHours: 8),
                    averageHoursPerDay: 8,
                    workingDaysLeft: 5,
                    monthHours: 160
                )
            )
            .previewDisplayName("Goal Reached - Acessory")
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))

            EHMDailyHoursWidgetView(
                entry: EHMWidgetEntry(
                    date: Date(),
                    groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(totalHours: 10),
                    averageHoursPerDay: 8,
                    workingDaysLeft: 5,
                    monthHours: 160
                )
            )
            .previewDisplayName("Exceeding Daily Goal  - Acessory")
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
        }
    }
}
