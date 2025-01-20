//
//  TimeEntriesView.swift
//  ehmTests
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI
import Foundation

struct TimeEntriesView: View {
    @StateObject private var viewModel: TimeEntriesViewModel = TimeEntriesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let error = viewModel.error {
                    VStack {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            Task {
                                await viewModel.fetchTimeEntries()
                            }
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.groupedTimeEntries.sorted(by: { $0.key.compare($1.key) == .orderedDescending }), id: \.key) { key, value in
                            Section(header: HStack {
                                Text(viewModel.getFormattedDate(date: key))
                                Spacer()
                                Text(viewModel.getSummedHours(timeEntries: value))
                            }) {
                                ForEach(value) { timeEntry in
                                    TimeEntryRowView(timeEntry: timeEntry)
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchTimeEntries()
                    }
                }
            }
            .navigationTitle("Time Entries")
        }
        .task {
            await viewModel.fetchTimeEntries()
        }
    }
}

struct TimeEntriesView_Previews: PreviewProvider {
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader(feature: testFeature_te04)
        let fakeClient = RedmineHTTPClient(downloader: fakeDownloader)
        let fakeProvider = RedmineTimeEntriesProvider(client: fakeClient)
        let _ = DataManager.initialize(provider: fakeProvider)
        
        NavigationView {
            TimeEntriesView()
        }
    }
}

