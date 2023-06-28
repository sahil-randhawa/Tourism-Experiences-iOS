//
//  User.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import Foundation

class User: ObservableObject {
    var email: String
    var password: String
    var name: String
    @Published var favorites: [String]
    
    
    init(email: String, password: String, name: String, favourites: [String]) {
        self.email = email
        self.password = password
        self.name = name
        self.favorites = favourites
    }
    
    init(){
        self.email = ""
        self.password = ""
        self.name = ""
        self.favorites = []
    }
    
    func addToFavourites(activity: Activity) {
        if !favorites.contains(activity.name) {
            favorites.append(activity.name)
            print("Added to Favorites")
            saveUserPreferences()
        }
    }
    
    func removeFromFavourites(activity: Activity) {
        favorites.removeAll { $0 == activity.name }
        print("Removed from Favorites")
        saveUserPreferences()
    }
    
    func saveUserPreferences() {
        UserDefaults.standard.set(favorites, forKey: "KEY_\(email)_Preferences")
    }
    
}

//class UserPreferences: ObservableObject {
//    @Published var favorites: [String]
//    init(favorites: [String]) {
//        self.favorites = favorites
//    }
//}

//struct UserPreferences: Codable {
//    var favorites: [String]
//}

