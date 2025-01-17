import SwiftUI

struct SettingsView: View {
    var body: some View {
        #if os(iOS)
        SettingsView_iOS()
        #elseif os(macOS)
        SettingsView_macOS()
        #endif
    }
}
