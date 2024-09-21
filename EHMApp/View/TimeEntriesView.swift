//
//  TimeEntriesView.swift
//  ehmTests
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI
import Foundation

struct TimeEntriesView : View {
    
    @EnvironmentObject var timeEntriesProvider: RedmineTimeEntriesProvider
    
    @State var hasError: Bool = false
    @State private var error: RedmineError?
    @State var groupedTimeEntries: Dictionary<Date, [RedmineTimeEntry]> = Dictionary<Date, [RedmineTimeEntry]>()
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(groupedTimeEntries.sorted(by: { $0.key.compare($1.key) == .orderedDescending }), id: \.key) { key, value in
                        Section(header: HStack {
                            Text(getFormattedDate(date: key))
                            Spacer()
                            Text(getSummedHours(timeEntries: value))
                        }) {
                            ForEach(value) { timeEntry in
                                TimeEntryRowView(timeEntry: timeEntry)
                            }
                        }
                    }
                }
                .navigationTitle("Activities")
                .refreshable {
                    await fetchTimeEntries()
                }
            }
        }.task {
            await fetchTimeEntries()
        }
    }
    
}

extension TimeEntriesView {
    func fetchTimeEntries() async {
        do {
            try await timeEntriesProvider.fetchTimeEntries()
            self.groupedTimeEntries = groupTimeEntries()
        } catch {
            self.hasError = true
        }
    }
    
    func groupTimeEntries() -> Dictionary<Date, [RedmineTimeEntry]> {
        return Dictionary(grouping: timeEntriesProvider.timeEntries, by: {$0.date})
    }
    
    func getFormattedDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "EEEE dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func getSummedHours(timeEntries: [RedmineTimeEntry]) -> String {
        return TimeEntryUtils.formatHours(timeEntries.reduce(0) { $0 + $1.hours })
    }
}

struct TimeEntriesView_Previews: PreviewProvider {
    @State static private var fakeData = RedmineTimeEntry.fakeEntries()
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader(feature: testFeature_te04)
        
        let client = RedmineHTTPClient(downloader: fakeDownloader)
        
        NavigationView {
            TimeEntriesView(groupedTimeEntries: fakeData)
                .environmentObject(RedmineTimeEntriesProvider(client: client))
            
        }
    }
}
