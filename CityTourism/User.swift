//
//  User.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import Foundation

class User: Codable {
    let email: String
    let password: String
    var preferences: UserPreferences
    
//    var favourites: [String] = []
    
    init(email: String, password: String, preferences: UserPreferences) {
        self.email = email
        self.password = password
        self.preferences = preferences
    }
    
    func addToFavourites(activity: Activity) {
        if !preferences.favorites.contains(activity.name) {
            preferences.favorites.append(activity.name)
            print("Added to Favorites")
            saveUserPreferences()
        }
    }

    func removeFromFavourites(activity: Activity) {
        preferences.favorites.removeAll { $0 == activity.name }
        print("Removed from Favorites")
        saveUserPreferences()
    }

    func saveUserPreferences() {
        if let preferencesData = try? JSONEncoder().encode(preferences) {
            UserDefaults.standard.set(preferencesData, forKey: "\(email)_Preferences")
        }
    }

    
//    // method to add an activity to favorites
//    func addToFavourites(activity: Activity) {
//        self.favourites.append(activity.name)
//        print("Added to Favourites")
//    }
//
//    // method to remove an activity from favorites
//    func removeFromFavourites(activity: Activity) {
//        favourites.removeAll { $0 == activity.name }
//        print("Removed from Favourites")
//    }
}

struct UserPreferences: Codable {
    var favorites: [String]
}

