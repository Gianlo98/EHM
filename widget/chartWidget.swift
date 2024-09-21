//
//  widget.swift
//  widget
//
//  Created by Gianlo Personal on 10.06.23.
//

import WidgetKit
import SwiftUI
import Intents


struct ConfigurationAppIntent2: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

struct Provider2: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry2 {
        SimpleEntry2(date: Date(), configuration: ConfigurationAppIntent2())
    }

    func snapshot(for configuration: ConfigurationAppIntent2, in context: Context) async -> SimpleEntry2 {
        SimpleEntry2(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent2, in context: Context) async -> Timeline<SimpleEntry2> {
        var entries: [SimpleEntry2] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry2(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry2: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent2
}

struct widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct chartWidget: Widget {
    let kind: String = "widget2"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent2.self, provider: Provider2()) { entry in
            widgetEntryView(entry: entry)
        }
    }
}

extension ConfigurationAppIntent2 {
    fileprivate static var smiley: ConfigurationAppIntent2 {
        let intent = ConfigurationAppIntent2()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent2 {
        let intent = ConfigurationAppIntent2()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    chartWidget()
} timeline: {
    SimpleEntry2(date: .now, configuration: .smiley)
    SimpleEntry2(date: .now, configuration: .starEyes)
}
