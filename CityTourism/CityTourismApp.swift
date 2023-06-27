//
//  CityTourismApp.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import SwiftUI

@main
struct CityTourismApp: App {
    
    // Create an instance of ActivityData and mark it as an environment object
    @StateObject private var activityData = ActivityData.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(activityData)
        }
    }
}
