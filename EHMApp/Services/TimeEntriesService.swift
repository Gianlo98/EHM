//
//  DataStorage.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//

import Foundation

class TimeEntriesService {
    let timeEntriesProvider: RedmineTimeEntriesProvider
    private let settingsManager: DataStorage
    
    init(provider: RedmineTimeEntriesProvider, settingsManager: DataStorage = .shared) {
        self.timeEntriesProvider = provider
        self.settingsManager = settingsManager
    }
    
    func fetchAndComputeStatistics() async throws -> (daysLeft: Int, avgHoursPerDay: Double) {
        try await timeEntriesProvider.fetchTimeEntries()
        let monthHours = await timeEntriesProvider.summedTimeEntries.last?.value ?? 0.0
        let monthlyThreshold = DataStorage.shared.loadKey(key: .monthlyHourThreshold)
        
        return TimeEntryUtils.getAverageHoursPerDayToReachMonthlyThreshold(
            monthlyThreshold: monthlyThreshold,
            monthHours: monthHours
        )
    }
}
