//
//  LogMealSwiftDataApp.swift
//  LogMealSwiftData
//
//  Created by Michelle Angela Aryanto on 30/10/24.
//

import SwiftUI
import SwiftData

@main
struct LogMealSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Meal.self])
    }
}
