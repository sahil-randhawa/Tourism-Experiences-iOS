//
//  FavouritesView.swift
//  CityTourism
//
//  Created by super on 2023-06-25.
//

import SwiftUI

struct FavouritesView: View {
    
    // currently logged user
    @EnvironmentObject var currentUser: User

    @EnvironmentObject var activityData: ActivityData
    
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationView{
            VStack{
                if (currentUser.favorites.count == 0) {
                    Text("You have no favorites added to the list.")
                }
                else{
                List{
                    ForEach(currentUser.favorites.indices, id: \.self) { index in
                        let currentActivity = activityData.activities.first (where: {$0.name == currentUser.favorites[index]})
                        
                        if let activity = currentActivity{
                            NavigationLink(destination: ActivityDetailsView(activity: activity).environmentObject(currentUser)) {
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
                        }// if
                        
                    }//ForEach
                    .onDelete{ indices in
                        currentUser.favorites.remove(atOffsets: indices)
                    }
                } //list
//                .onAppear(){
//                    currentUser.favorites = UserDefaults.standard.array(forKey: "KEY_\(currentUser.email)_Preferences") as? [String] ?? []
//                }
//                .onChange(of: currentUser.favorites){ _ in
//                    UserDefaults.standard.set(currentUser.favorites, forKey: "KEY_\(currentUser.email)_Preferences")
//                }
//                if(favouritesOnly){
                Button{
                    currentUser.favorites.removeAll()
                    currentUser.saveUserPreferences()
                }label:{
                    Text("Clear Favourites")
                }
                .padding()
                }
            }//VStack
            .onAppear(){
                currentUser.favorites = UserDefaults.standard.array(forKey: "KEY_\(currentUser.email)_Preferences") as? [String] ?? []
            }
            .onChange(of: currentUser.favorites){ _ in
                UserDefaults.standard.set(currentUser.favorites, forKey: "KEY_\(currentUser.email)_Preferences")
            }
            .navigationTitle("Favourites")
            .navigationBarItems(trailing: logoutButton)
        }//navView
    }
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
        UserDefaults.standard.removeObject(forKey: "KEY_CurrentUserEmail")
        UserDefaults.standard.removeObject(forKey: "KEY_RememberMe")
        isLoggedIn.toggle()
//        dismiss()
    }
}

//struct FavouritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesView()
//    }
//}
