//
//  TimeBoxApp.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import SwiftUI

@main
struct TimeBoxApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, RealmMigrator.configuration)
        }
    }
}
