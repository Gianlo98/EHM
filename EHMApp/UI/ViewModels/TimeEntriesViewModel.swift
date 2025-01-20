//
//  TimeEntriesViewModel.swift
//  EHM
//
//  Created by Gianlo Personal on 20.01.2025.
//

import SwiftUI

@MainActor
class TimeEntriesViewModel: ObservableObject {
    @Published var groupedTimeEntries: [Date: [RedmineTimeEntry]] = [:]
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private var dataManager: DataManager = DataManager.shared
    
    func fetchTimeEntries() async {
        isLoading = true
        error = nil
        
        do {
            try await dataManager.fetchData()
        } catch {
            print(error)
        }
        
        groupedTimeEntries = groupTimeEntries(dataManager.timeEntries)
        
        isLoading = false
    }
    
    // MARK: - Helpers
    private func groupTimeEntries(_ timeEntries: [RedmineTimeEntry]) -> [Date: [RedmineTimeEntry]] {
        Dictionary(grouping: timeEntries, by: { $0.date })
    }
    
    func getFormattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func getSummedHours(timeEntries: [RedmineTimeEntry]) -> String {
        let totalHours = timeEntries.reduce(0) { $0 + $1.hours }
        return TimeEntryUtils.formatHours(totalHours)
    }
}
