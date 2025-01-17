//
//  EHMWidget.swift
//  EHMWidget
//
//  Created by Gianlo Personal on 17.01.2025.
//

import WidgetKit
import SwiftUI
import Charts


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> EHMWidgetEntry {
        EHMWidgetEntry(
            date: Date(),
            groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(),
            averageHoursPerDay: 8,
            workingDaysLeft: 5,
            monthHours: 160
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (EHMWidgetEntry) -> Void) {
        // Provide a snapshot using saved widget data
        let entry = WidgetDataStorage.shared.loadWidgetData()
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<EHMWidgetEntry>) -> Void) {
        // Fetch the latest data and create a timeline
        let entry = WidgetDataStorage.shared.loadWidgetData()
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

// Widget View
struct EHMWidgetEntryView: View {
    let entry: EHMWidgetEntry
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                Text("Hours Booked: \(entry.monthHours, specifier: "%.2f")")
                    .font(.title2.bold())
                Text("Days left: \(entry.workingDaysLeft), Avg. Hours/Day: \(entry.averageHoursPerDay, specifier: "%.2f")")
                    .font(.footnote.bold())
            }
            
            RelativeBarChart(chartData: .constant(entry.groupedTimeEntries))
        }
        .padding()
        .scaledToFit()
        .containerBackground(for: .widget) {
            Color(.systemBackground)
        }
    }
}

// Main Widget Configuration
struct EHMWidget: Widget {
    let kind: String = "EHMWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EHMWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("EHM Chart Widget")
        .description("Displays a relative bar chart of your time entries.")
        .supportedFamilies([.systemLarge])
    }
}

// Widget Previews
struct EHMWidget_Previews: PreviewProvider {
    static var previews: some View {
        EHMWidgetEntryView(entry:         EHMWidgetEntry(
            date: Date(),
            groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(),
            averageHoursPerDay: 8,
            workingDaysLeft: 5,
            monthHours: 160
        )).previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
