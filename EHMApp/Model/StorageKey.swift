//
//  StorageKeys.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//


struct StorageKey<T>: Equatable {
    let name: String
    let defaultValue: T
    
    init(_ name: String, _ defaultValue: T) {
        self.name = name
        self.defaultValue = defaultValue
    }
    
    static func == (lhs: StorageKey<T>, rhs: StorageKey<T>) -> Bool {
        return lhs.name == rhs.name
    }
    
    static var redmineApiKey: StorageKey<String> { StorageKey<String>("redmineApiKey", "") }
    static var redmineApiUrl: StorageKey<String> { StorageKey<String>("redmineApiUrl", "https://redmine.example.com") }
    static var fixedCostThreshold: StorageKey<Double> { StorageKey<Double>("fixedCostThreshold", 2000) }
    static var hourlyIncome: StorageKey<Double> { StorageKey<Double>("hourlyIncome", 35) }
    static var monthlyHourThreshold: StorageKey<Double> { StorageKey<Double>("monthlyHourThreshold", 165) }
}
