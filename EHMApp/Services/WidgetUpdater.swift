//
//  WidgetUpdater.swift
//  EHM
//
//  Created by Gianlo Personal on 20.01.2025.
//

import Foundation
import WidgetKit
import KeychainSwift

class WidgetUpdater {
    private let sharedDefaults = UserDefaults(suiteName: "group.com.mangayo.ehm")
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - Save Data
    func updateWidget(with: EHMWidgetEntry) {
        do {
            let chartData = try encoder.encode(with.groupedTimeEntries)
            sharedDefaults?.set(chartData, forKey: SharedKeys.chartData)
            
            sharedDefaults?.set(with.workingDaysLeft, forKey: SharedKeys.workingDaysLeft)
            sharedDefaults?.set(with.averageHoursPerDay, forKey: SharedKeys.averageHoursPerDay)
            sharedDefaults?.set(with.monthHours, forKey: SharedKeys.monthHours)
            
            WidgetCenter.shared.reloadAllTimelines()
            WidgetCenter.shared.getCurrentConfigurations { result in
                switch result {
                case .success(let widgetInfoList):
                    print("Successfully retrieved widget configurations:")
                    for widgetInfo in widgetInfoList {
                        print("WidgetInfo ID: \(widgetInfo.id)")
                        print("Family: \(widgetInfo.family)")
                        print("Kind: \(widgetInfo.kind)")
                    }
                    print("Total Widgets: \(widgetInfoList.count)")
                case .failure(let error):
                    print("Failed to retrieve widget configurations: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to save widget data: \(error)")
        }
    }
}
