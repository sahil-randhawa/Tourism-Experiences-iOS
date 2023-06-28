//
//  TabbedView.swift
//  CityTourism
//
//  Created by super on 2023-06-25.
//

import SwiftUI

struct TabbedView: View {
    
    @Binding var isLoggedIn: Bool
    
    // currently logged user
    @EnvironmentObject var currentUser: User

    @EnvironmentObject var activityData: ActivityData
    
    
    var body: some View {
        NavigationView{
            TabView{
                ActivitiesView(isLoggedIn: $isLoggedIn).environmentObject(currentUser)
                    .environmentObject(activityData)
                    .tabItem {
                        VStack{
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .padding(20)
                    }
                FavouritesView(isLoggedIn: $isLoggedIn).environmentObject(currentUser)
                    .environmentObject(activityData)
                    .tabItem {
                        VStack{
                            Image(systemName: "heart.fill")
                            Text("Favourites")
                        }
                        .padding(20)
                    }
            } //tabview
        }//navView
        .navigationBarBackButtonHidden(true)
        .onAppear(){
        }
    }//body
}

//struct TabbedView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabbedView()
//    }
//}
