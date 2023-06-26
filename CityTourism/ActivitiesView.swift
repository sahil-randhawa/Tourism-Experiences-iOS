//
//  ActivitiesView.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import SwiftUI


struct ActivitiesView: View {
//    let activities = ActivityData.shared.activities
    
    @State private var favouritesOnly: Bool = false
    
    @State private var activitiesSet = ActivityData.shared.activities
    
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
    
    var activities: [Activity] {
        guard let currentUser = currentUser, favouritesOnly else {
            return activitiesSet
        }
        return activitiesSet.filter { currentUser.preferences.favorites.contains($0.name) }
    }

    @Binding var isLoggedIn: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
//            Toggle("Favourites", isOn: $favouritesOnly)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 20)
            List(activities, id: \.name) { activity in
                NavigationLink(destination: ActivityDetailsView(activity: activity, currentUser: currentUser!)) {
                    HStack {
                        Image(activity.photo[0])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                        VStack(alignment: .leading){
                            Text(activity.name)
                                .font(.headline)
                            
                            Text("\(activity.price) per head")
                                .font(.subheadline)
                            
                            Text("★ \(activity.starRating)/5")
                                .font(.subheadline)
                            Spacer()
                        }.padding(.vertical)
                    }// hstack
                } //navlink
            } //list
            if(favouritesOnly){
                Button{
                    currentUser!.preferences.favorites.removeAll()
                    currentUser!.saveUserPreferences()
                    favouritesOnly = false
                }label:{
                    Text("Clear Favourites")
                }.padding()
            }
        }//vstack
            .navigationTitle("Toronto Experiences")
            .navigationBarItems(trailing: logoutButton)
//            .navigationBarTitleDisplayMode(.large)
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 10)
        }// navView
//        .onAppear{
//            favouritesOnly = false
//            activities = activitiesFilter()
//        }
        
    }//body
    private var logoutButton: some View {
        Button(action: {
            logout()
        }) {
            Text("Logout")
                .foregroundColor(.red)
            Image(systemName: "power")
                .foregroundColor(.red)
        }
    }

    private func logout() {
        UserDefaults.standard.removeObject(forKey: "CurrentUser")
        UserDefaults.standard.removeObject(forKey: "RememberMe")
        isLoggedIn.toggle()
//        dismiss()
    }
}

//struct ActivitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivitiesView_Previews(isLoggedIn: isLoggedIn)
//    }
//}

