//
//  DataService.swift
//  EHM
//
//  Created by Gianlo Personal on 20.01.2025.
//

import Foundation
import Combine

@MainActor
class DataManager: ObservableObject {
    var timeEntries: [RedmineTimeEntry] = []
    var groupedTimeEntries: [GroupedTimeEntry] = []
    var summedTimeEntries: [GroupedTimeEntry] = []
    var currentUser: RedmineCurrentUser?
    var isLoading: Bool = false
    var daysLeft: Int = 0
    var avgPerDay: Double = 0
    
    var dateFrom: Date = Date.now.startOfMonth()
    var dateTo: Date = Date.now.endOfMonth()
    
    private let provider: RedmineTimeEntriesProvider
    private let widgetUpdater: WidgetUpdater = WidgetUpdater()
    static private var _shared: DataManager?

    static var shared: DataManager {
        guard let instance = _shared else {
            return DataManager.initialize(provider: RedmineTimeEntriesProvider())
        }
        return instance
    }

    private init(provider: RedmineTimeEntriesProvider) {
        self.provider = provider
    }

    static func initialize(provider: RedmineTimeEntriesProvider) -> DataManager {
        guard _shared == nil else {
            return _shared!
        }
        _shared = DataManager(provider: provider)
        return _shared!
    }

    // MARK: - Public Methods
    func fetchData() async throws {
        guard !isLoading else { return }
        isLoading = true
        
        self.currentUser = try await provider.fetchCurrentUser()
        try await provider.fetchTimeEntries()
        
        
        self.timeEntries = provider.timeEntries
        self.groupedTimeEntries = provider.groupedTimeEntries
        self.summedTimeEntries = provider.summedTimeEntries
        
        // Compute Statistics
        await computeStatistics()
        
        // Notify Widgets
        await updateWidgets()

        isLoading = false
    }
    
    func updateData<T>(value: T, key: StorageKey<T>) {
        DataStorage.shared.updateKey(value: value, key: key)
    }
    
    func updateWidgets() async {
        let widgetData = EHMWidgetEntry(
            date: Date(),
            groupedTimeEntries: groupedTimeEntries,
            averageHoursPerDay: avgPerDay,
            workingDaysLeft: daysLeft,
            monthHours: summedTimeEntries.last?.value ?? 0.0
        )
        
        widgetUpdater.updateWidget(with: widgetData)
    }
    
    // MARK: Private Methods
    private func computeStatistics() async {
        let monthHours = self.summedTimeEntries.last?.value ?? 0.0
        let monthlyThreshold = DataStorage.shared.loadKey(key: .monthlyHourThreshold)
                
        let (daysLeft, avgPerDay) = TimeEntryUtils.getAverageHoursPerDayToReachMonthlyThreshold(
            monthlyThreshold: monthlyThreshold,
            monthHours: monthHours
        )
        
        self.daysLeft = daysLeft
        self.avgPerDay = avgPerDay
    }
}
