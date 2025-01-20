//
//  TimeEntryRowView.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI

let renuoColor = Color(red: 0.15, green: 0.84, blue: 0.62)

struct TimeEntryRowView: View {
    var timeEntry: RedmineTimeEntry
    
    var body: some View {
        HStack {
            Text("\(timeEntry.hours.formatted(.number.precision(.fractionLength(1))))h")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(renuoColor)
                .padding(.trailing, 25)
            VStack(alignment: .leading) {
                Text(timeEntry.project.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text("\(timeEntry.comment)")
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
    }
}


struct TimeEntryRowView_Previews: PreviewProvider {
    static var timeEntry = RedmineTimeEntry(
        id: 1,
        comment: "REN-30303 and bla bla bla",
        hours: 10.2,
        project: RedmineProject(id: 1, name: "renovero"),
        activity: RedmineActivity(id: 1, name: "activity"),
        date: Date.now
    )
    static var previews: some View {
        
        Group {
            TimeEntryRowView(timeEntry: timeEntry)
                .padding()

        }
        .previewLayout(.sizeThatFits)
        
    }
}

