//
//  DataStorage.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//

import Foundation
import WidgetKit
import KeychainSwift

class DataStorage {
    
    static let shared = DataStorage()
    private let sharedDefaults = UserDefaults(suiteName: "group.com.mangayo.ehm")
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    // MARK: - Save Data
    func saveWidgetData(entry: EHMWidgetEntry) {
        do {
            let chartData = try encoder.encode(entry.groupedTimeEntries)
            
            sharedDefaults?.set(chartData, forKey: SharedKeys.chartData)
            
            sharedDefaults?.set(entry.workingDaysLeft, forKey: SharedKeys.workingDaysLeft)
            sharedDefaults?.set(entry.averageHoursPerDay, forKey: SharedKeys.averageHoursPerDay)
            sharedDefaults?.set(entry.monthHours, forKey: SharedKeys.monthHours)
            
            // Notify the widget to refresh
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            print("Failed to save widget data: \(error)")
        }
    }
    
    func updateKey<T>(value: T, key: StorageKey<T>) {
        if key.name == StorageKey<String>.redmineApiKey.name {
            let keychain = KeychainSwift()
            guard let stringValue = value as? String else { return }
            keychain.set(stringValue, forKey: key.name)
        } else {
            UserDefaults.standard.set(value, forKey: key.name)
        }
    }
    
    func loadKey<T>(key: StorageKey<T>) -> T {
        if key.name == StorageKey<String>.redmineApiKey.name {
            let keychain = KeychainSwift()
            if let stringValue = keychain.get(key.name) as? T {
                return stringValue
            } else {
                return key.defaultValue
            }
        } else if let value = UserDefaults.standard.object(forKey: key.name) as? T {
            return value
        } else {
            return key.defaultValue
        }
    }
}
