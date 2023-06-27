//
//  TabbedView.swift
//  CityTourism
//
//  Created by super on 2023-06-25.
//

import SwiftUI

struct TabbedView: View {
    
    @Binding var isLoggedIn: Bool
    @EnvironmentObject var activityData: ActivityData
    
    // currently logged user
    var currentUser: User? = {
        guard let userData = UserDefaults.standard.data(forKey: "CurrentUser"),
              let user = try? PropertyListDecoder().decode(User.self, from: userData)
        else {
            return nil
        }
        print(user.email)
        return user
    }()
    
    var favActivities: [Activity] {
        guard let currentUser = currentUser else {
            return activityData.activities
        }
        return activityData.activities.filter { currentUser.preferences.favorites.contains($0.name) }
    }
    
    var body: some View {
        NavigationView{
            TabView{
                ActivitiesView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        VStack{
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .padding(20)
                    }
                FavouritesView(isLoggedIn: $isLoggedIn, activities: favActivities)
                    .tabItem {
                        VStack{
                            Image(systemName: "heart.fill")
                            Text("Favourites")
                        }
                        .padding(20)
                    }
            } //tabview
        }//navView
        .environmentObject(activityData)
//        .navigationBarItems(trailing: logoutButton)
        .navigationBarBackButtonHidden(true)
        
    }//body
//    private var logoutButton: some View {
//        Button(action: {
//            logout()
//        }) {
//            Text("Logout")
//        }
//    }
//    
//    private func logout() {
//        UserDefaults.standard.removeObject(forKey: "CurrentUser")
//        UserDefaults.standard.removeObject(forKey: "RememberMe")
//        isLoggedIn.toggle()
////        dismiss()
//    }
}

//struct TabbedView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabbedView()
//    }
//}
