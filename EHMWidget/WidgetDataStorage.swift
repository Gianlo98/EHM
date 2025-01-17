//
//  WidgetDataStorage.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//
import Foundation

class WidgetDataStorage {
    
    static let shared = WidgetDataStorage()
    private let sharedDefaults = UserDefaults(suiteName: "group.com.mangayo.ehm")
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    // MARK: - Load Data
    func loadWidgetData() -> EHMWidgetEntry {
        
        let chartData: [GroupedTimeEntry] = {
            if let data = sharedDefaults?.data(forKey: SharedKeys.chartData),
               let decoded = try? decoder.decode([GroupedTimeEntry].self, from: data) {
                return decoded
            }
            return GroupedTimeEntry.fakeGroupedData()
        }()
        
        let monthHours = sharedDefaults?.double(forKey: SharedKeys.monthHours) ?? 0
        let workingDaysLeft = sharedDefaults?.integer(forKey: SharedKeys.workingDaysLeft) ?? 0
        let averageHoursPerDay = sharedDefaults?.double(forKey: SharedKeys.averageHoursPerDay) ?? 0
        
        return EHMWidgetEntry(
            date: Date(),
            groupedTimeEntries: chartData,
            averageHoursPerDay: averageHoursPerDay,
            workingDaysLeft: workingDaysLeft,
            monthHours: monthHours
        )
    }
}
