//
//  EHMWidget.swift
//  EHMWidget
//
//  Created by Gianlo Personal on 17.01.2025.
//

import WidgetKit
import SwiftUI
import Charts

// Widget View
struct EHMMonthlyChartWidgetView: View {
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
struct EHMMonthlyChartWidget: Widget {
    let kind: String = "EHMMonthlyChartWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetProvider()) { entry in
            EHMMonthlyChartWidgetView(entry: entry)
        }
        .configurationDisplayName("EHM Monthly Hours")
        .description("Displays the chart of your monthly time entries.")
        .supportedFamilies([.systemLarge])
    }
}

// Widget Previews
struct EHMMonthlyChartWidget_Previews: PreviewProvider {
    static var previews: some View {
        EHMMonthlyChartWidgetView(entry:         EHMWidgetEntry(
            date: Date(),
            groupedTimeEntries: GroupedTimeEntry.fakeGroupedData(),
            averageHoursPerDay: 8,
            workingDaysLeft: 5,
            monthHours: 160
        )).previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
