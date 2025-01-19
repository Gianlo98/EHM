//
//  EHMWidget.swift
//  EHMWidget
//
//  Created by Gianlo Personal on 17.01.2025.
//

import WidgetKit
import SwiftUI

struct EHMDailyHoursWidgetView: View {
    let entry: EHMWidgetEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            let todayHours = entry.groupedTimeEntries.totalHoursToday()
            let (emoji, textMessage) = determineMessage(for: todayHours)
            
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
    
    
    func determineMessage(for todayHours: Double) -> (emoji: String, text: String) {
        if isWeekend() {
            return ("🎉", "Enjoy your weekend!")
        }
        
        switch todayHours {
        case 0:
            return ("🌅", "Start logging your hours!")
        case 0..<entry.averageHoursPerDay/2:
            return ("🚀", "Good start, keep it up!")
        case entry.averageHoursPerDay/2..<entry.averageHoursPerDay:
            return ("👏", "Nice progress, almost there!")
        case (entry.averageHoursPerDay - 0.1) ..< (entry.averageHoursPerDay + 0.3) :
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
}

extension Array where Element == GroupedTimeEntry {
    /// Returns total hours booked for **today**.
    func totalHoursToday() -> Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return self
            .filter { calendar.isDate($0.date, inSameDayAs: today) }
            .reduce(0) { $0 + $1.value }
    }
}


struct EHMDailyHoursWidget: Widget {
    let kind: String = "EHMDayliHoursWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetProvider()) { entry in
            EHMDailyHoursWidgetView(entry: entry)
        }
        .configurationDisplayName("EHM Daily Hours")
        .description("Displays how many hours were booked today, plus motivational feedback.")
        .supportedFamilies([.systemSmall])
    }
}


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
        }
    }
}
