//
//  TimeEntry.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation

struct RedmineTimeEntry: Identifiable {
    let id: Int
    let comment: String
    let hours: Double
    let project: RedmineProject
    let activity: RedmineActivity
    let date: Date
}


extension RedmineTimeEntry: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case project
        case activity
        case hours
        case comments
        case date = "spent_on"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawComment = try? values.decode(String.self, forKey: .comments)
        let rawProject = try? values.decode(RedmineProject.self, forKey: .project)
        let rawActivity = try? values.decode(RedmineActivity.self, forKey: .activity)
        let rawDate = try? values.decode(String.self, forKey: .date)

        var rawHours: Double?
        if let rawHoursStr = try? values.decode(String.self, forKey: .hours) {
            rawHours = Double(rawHoursStr)
        } else if let rawHoursDouble = try? values.decode(Double.self, forKey: .hours) {
            rawHours = rawHoursDouble
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let id = rawId,
              let comments = rawComment,
              let project = rawProject,
              let activity = rawActivity,
              let hours = rawHours,
              let date = dateFormatter.date(from: rawDate!)
        else {
            throw RedmineError.missingData
        }
        
        self.id = id
        self.comment = comments
        self.project = project
        self.activity = activity
        self.hours = hours
        self.date = date
        

    }
}

extension RedmineTimeEntry {
    static func fakeEntries() -> Dictionary<Date, [RedmineTimeEntry]> {
        var timeEntries: [RedmineTimeEntry] = []
        
        let project = RedmineProject(id: 1, name: "Project")
        let activity = RedmineActivity(id: 1, name: "Activity")
        
        for i in 1...30 {
            let date = Calendar.current.date(byAdding: .day, value: i * -1, to: Date())
            let value = date!.dayNumberOfWeek()! <= 5 ? Double.random(in: 2.0 ..< 12.0) : 0
            timeEntries.append(RedmineTimeEntry(
                id: i,
                comment: "Comment",
                hours: value,
                project: project,
                activity: activity,
                date: date!
            ))
        }
        
        return Dictionary(grouping: timeEntries, by: {$0.date})
    }

}



