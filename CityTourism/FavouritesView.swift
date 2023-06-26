//
//  FavouritesView.swift
//  CityTourism
//
//  Created by super on 2023-06-25.
//

import SwiftUI

struct FavouritesView: View {
    
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
        guard let currentUser = currentUser else {
            return activitiesSet
        }
        return activitiesSet.filter { currentUser.preferences.favorites.contains($0.name) }
    }
    
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(activities, id: \.name) { activity in
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
                    }//ForEach
                    .onDelete(perform: { indexSet in
                        
                        for index in indexSet{
                            let activityToRemove = self.activities[index]
                            
                            currentUser!.removeFromFavourites(activity: activityToRemove)
                            currentUser!.saveUserPreferences()
                        }
                        
                    })
                } //list
//                if(favouritesOnly){
                Button{
                    currentUser!.preferences.favorites.removeAll()
                    currentUser!.saveUserPreferences()
                }label:{
                    Text("Clear Favourites")
                }
                .padding()
//                }
            }
            .navigationTitle("Favourites")
            .navigationBarItems(trailing: logoutButton)
        }
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
        UserDefaults.standard.removeObject(forKey: "CurrentUser")
        UserDefaults.standard.removeObject(forKey: "RememberMe")
        isLoggedIn.toggle()
//        dismiss()
    }
}

//struct FavouritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesView()
//    }
//}
