//
//  ActivityDetailsView.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import SwiftUI

struct ActivityDetailsView: View {
    
    let activity: Activity
    
    let currentUser: User
    
    
    
    @State private var favIcon:String = "heart"
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(activity.name)
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(activity.photo, id: \.self) { photo in
                        Image(photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                    }
                }
                .padding(.horizontal, 10)
            }
//            HStack {
//                ForEach(activity.photo, id: \.self) { photo in
//                    Image(photo)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                }
//            }.padding(.horizontal, 40)
            
            Text(activity.description)
                .foregroundColor(.gray)
            
            HStack {
                ForEach(0..<activity.starRating){ _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                ForEach(activity.starRating..<5){ _ in
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                }
//                Text("\(activity.starRating)/5")
//                    .foregroundColor(.gray)
            }
            
            HStack{
                
                Text("Hosted by:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Button(action:{
                    let phone = "416-415-5000"
                    
                    //create a formatted string to represent phone number
                    let formattedString : String = "tel://\(phone)"
                    
                    //obtain URL using the formatted string to be used by the in-built phone app
                    guard let phoneURL = URL(string: formattedString) else{
                        print("phone number cannot be conveted in appropriate URL")
                        return
                    }
                    print(phoneURL)
                    
                    UIApplication.shared.open(phoneURL)
                }){
                    Text("\(activity.host) ☎️")
                        .font(.body)
                }
            }
            
            
            Text("Price: \(activity.price) per head")
            
            HStack {
                Button(action: {
                    // Add the activity to favourites
                    
//                    toggleFavorite()
                    
                    
//                    if let currentUser = currentUser {
                        if isFavouriteActivity() {
                            currentUser.removeFromFavourites(activity: activity)
                            self.favIcon = "heart"
                        } else {
                            currentUser.addToFavourites(activity: activity)
                            self.favIcon = "heart.fill"

                        }
//                    }
                    
                }) {
                    HStack{
                        Image(systemName: favIcon)
                            .foregroundColor(isFavouriteActivity() ? .red : .black)
                        Text("Favourite")
                    }
                    .onAppear{
                        if(isFavouriteActivity()){
                            self.favIcon = "heart.fill"
                        }else{
                            self.favIcon = "heart"
                        }
                    }
                }.buttonStyle(.bordered)
                
                
                ShareLink(item: "\(activity.name) - \(activity.price)"){
                    HStack{
                    Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                }.buttonStyle(.bordered)
                
            }
            Spacer()
        }
        .padding()
//        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    private func isFavouriteActivity() -> Bool {
        
        return currentUser.preferences.favorites.contains(activity.name)
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let myactivity = ActivityData.shared.activities[0]
        let user:User = User(email: "james", password: "james", preferences: UserPreferences(favorites: []))
        ActivityDetailsView(activity: myactivity, currentUser: user)
    }
}
