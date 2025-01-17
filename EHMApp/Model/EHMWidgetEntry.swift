//
//  EHMWidgetEntry.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//

import Foundation
import WidgetKit

struct EHMWidgetEntry: TimelineEntry {
    let date: Date
        
    let groupedTimeEntries: [GroupedTimeEntry]
    
    let averageHoursPerDay: Double
    let workingDaysLeft: Int
    let monthHours: Double
}
