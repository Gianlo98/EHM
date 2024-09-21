//
//  ChartView.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI
import Charts


struct ChartView: View {
    
    @EnvironmentObject var timeEntriesProvider: RedmineTimeEntriesProvider
    
    @State var isLoading: Bool = false
    
    @State var hourlyWage: Double = 0
    @State var todayHours: Double = 0
    @State var monthHours: Double = 160
    @State var monhtlyThreshold: Double = UserDefaults.standard.double(forKey: "monthlyHourTreshold")
    
    var body: some View {
        let daysInMonth = daysInCurrentMonth()
        let workingDaysPassed = workingDaysPassedInMonth()
        let workingDaysLeft = daysInMonth - workingDaysPassed
        let hoursNeeded = max(monhtlyThreshold - monthHours, 0)
        let averageHoursPerDay = workingDaysLeft > 0 ? hoursNeeded / Double(workingDaysLeft) : 0
        
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.secondarySystemBackground))
                
                VStack {
                    HStack {
                        Text("🏦 ")
                            .font(.largeTitle.bold())
                            .padding(.leading, 20)
                        Spacer()
                        Text("Period: \(monthHours * hourlyWage, specifier: "%.0f .-")")
                            .font(.largeTitle.bold())
                            .padding()
                    }
                    
                    AbsoluteLineChart(chartData: $timeEntriesProvider.summedTimeEntries)
                }
            }.padding()
                .frame(width: UIScreen.main.bounds.size.width)
                .scaledToFit()
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.secondarySystemBackground))
                
                VStack {
                    HStack {
                        Text("📅")
                            .font(.largeTitle.bold())
                            .padding(.leading, 20)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Hours booked: \(monthHours, specifier: "%.2f")")
                                .font(.title.bold())
                            Text("Days left: \(workingDaysLeft), Avg. Hours/Day: \(averageHoursPerDay, specifier: "%.2f")")
                                .font(.footnote.bold())
                        }.padding()
                    }
                    
                    RelativeBarChart(chartData:  $timeEntriesProvider.groupedTimeEntries)
                }
            }.padding()
                .frame(width: UIScreen.main.bounds.size.width)
                .scaledToFit()
            
            Spacer()
            Spacer()
        }.refreshable {
            await fetchTimeEntries()
        }.task {
            await fetchTimeEntries()
        }.onAppear() {
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { _ in
                self.monhtlyThreshold = UserDefaults.standard.double(forKey: "monthlyHourTreshold")
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
        }
    }
    
    
    func daysInCurrentMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let weekdays = Set([2, 3, 4, 5, 6]) // Monday to Friday
        
        var workingDays = 0
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth),
               let weekday = calendar.dateComponents([.weekday], from: date).weekday,
               weekdays.contains(weekday) {
                workingDays += 1
            }
        }
        
        return workingDays
    }
    
    // Calculate the number of working days passed in the month up to the current date
    func workingDaysPassedInMonth() -> Int {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        let today = calendar.startOfDay(for: Date())
        let weekdays = Set([2, 3, 4, 5, 6]) // Assuming working days are Monday to Friday (1 = Sunday, 7 = Saturday)
        
        let days = calendar.dateComponents([.day], from: startOfMonth, to: today).day!
        var workingDays = 0
        
        for day in 0...days {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth),
               let weekday = calendar.dateComponents([.weekday], from: date).weekday,
               weekdays.contains(weekday) {
                workingDays += 1
            }
        }
        
        return workingDays
    }
    
}




extension ChartView {
    func getCurrentMonth() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date.now)
    }
    
    func fetchTimeEntries() async {
        isLoading = true
        do {
            try await timeEntriesProvider.fetchTimeEntries()
            
            self.hourlyWage = UserDefaults.standard.double(forKey: "hourlyIncome")
            self.todayHours = self.timeEntriesProvider.groupedTimeEntries.last?.value ?? 0.0
            self.monthHours = self.timeEntriesProvider.summedTimeEntries.last?.value ?? 0.0
        } catch {
            //            self.hasError = true
        }
        isLoading = false
    }
}




struct ChartView_Preview: PreviewProvider {
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader(feature: testFeature_te04)
        let client = RedmineHTTPClient(downloader: fakeDownloader)
        
        ChartView()
            .environmentObject(RedmineTimeEntriesProvider(client: client))
    }
}
