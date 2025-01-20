import SwiftUI

@MainActor
class ChartViewModel: ObservableObject {
    private var dataManager: DataManager = DataManager.shared
    
    @Published var isLoading: Bool = false
    @Published var hourlyWage: Double = 0
    @Published var monthHours: Double = 0
    @Published var workingDaysLeft: Int = 0
    @Published var averageHoursPerDay: Double = 0
    @Published var monthlyThreshold: Double = 0
    @Published var groupedTimeEntries: [GroupedTimeEntry] = []
    @Published var summedTimeEntries: [GroupedTimeEntry] = []
    
    
    func fetchData() async {
        isLoading = true
        do {
            try await dataManager.fetchData()
            
            // Update statistics
            self.workingDaysLeft = dataManager.daysLeft
            self.averageHoursPerDay = dataManager.avgPerDay
            
            // Update other data
            self.summedTimeEntries = dataManager.summedTimeEntries
            self.groupedTimeEntries = dataManager.groupedTimeEntries
            self.monthHours = self.summedTimeEntries.last?.value ?? 0.0
            self.hourlyWage = DataStorage.shared.loadKey(key: .hourlyIncome)
            self.monthlyThreshold = DataStorage.shared.loadKey(key: .monthlyHourThreshold)
            
        } catch {
            print("Error fetching data: \(error)")
        }
        isLoading = false
    }
}
