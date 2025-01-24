//
//  WidgetProvider.swift
//  EHM
//
//  Created by Gianlo Personal on 19.01.2025.
//

import WidgetKit

struct WidgetProvider: TimelineProvider {
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
        print("Getting snapshot \(entry)")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<EHMWidgetEntry>) -> Void) {
        // Fetch the latest data and create a timeline
        let entry = WidgetDataStorage.shared.loadWidgetData()
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        print("Getting timeline \(timeline)")
        completion(timeline)
    }
}
