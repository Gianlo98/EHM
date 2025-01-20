//
//  SettingsViewModel.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//

import Foundation
import SwiftUI
import KeychainSwift

@MainActor
class MainViewModel: ObservableObject {
    @AppStorage(StorageKey<Bool>.isConfigured.name) var isConfigured: Bool = false

}
