//
//  ActivitiesView.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import SwiftUI


struct ActivitiesView: View {
    
    
    // currently logged user
    @EnvironmentObject var currentUser: User

    
    @EnvironmentObject var activityData: ActivityData
    
    @Binding var isLoggedIn: Bool
    
//    @State private var favouritesOnly: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
            List(activityData.activities, id: \.name) { activity in
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
            } //list
        }//vstack
            .navigationTitle("Toronto Experiences")
            .navigationBarItems(trailing: logoutButton)
//            .navigationBarTitleDisplayMode(.large)
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 10)
        }// navView
        
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
        UserDefaults.standard.removeObject(forKey: "KEY_CurrentUserEmail")
        UserDefaults.standard.removeObject(forKey: "KEY_RememberMe")
        isLoggedIn.toggle()
//        dismiss()
    }
}

//struct ActivitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivitiesView_Previews(isLoggedIn: isLoggedIn)
//    }
//}

