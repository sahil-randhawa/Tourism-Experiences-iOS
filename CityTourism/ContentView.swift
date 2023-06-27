//
//  ContentView.swift
//  CityTourism
//
//  Created by super on 2023-06-14.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var activityData: ActivityData
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false

    @State private var showLoginPrompt: Bool = false
    
    let usersDataSet = [
        User(email: "a", password: "1", preferences: UserPreferences(favorites: [])),
        User(email: "vaisrav@gmail.com", password: "12345", preferences: UserPreferences(favorites: [])),
        User(email: "sahil@gmail.com", password: "12345", preferences: UserPreferences(favorites: []))
    ]
    
    // currently logged user
    @State private var currentUser: User? = {
        guard let userData = UserDefaults.standard.data(forKey: "CurrentUser"),
              let user = try? PropertyListDecoder().decode(User.self, from: userData)
        else {
            return nil
        }
        return user
    }()
    
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
//                Color(hex: "EAF0F6")
            
                VStack(spacing: 0) {
                    Text("City Tourism")
                        .font(.largeTitle)
                        .foregroundColor(.indigo)
                    Image("home")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 340)
                        .cornerRadius(20)
                        .padding()
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
//                        .background(Color.white)
                        .cornerRadius(10)
                        .font(.system(size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: "CBBAF4"), lineWidth: 2)
                        )
                        .padding(.horizontal)
                        .padding(.vertical)
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
//                        .background(Color.white)
                        .cornerRadius(10)
                        .font(.system(size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: "CBBAF4"), lineWidth: 2)
                        )
                        .padding(.horizontal)
                        .padding(.vertical)
                    
                    Toggle("Remember Me", isOn: $rememberMe)
                        .padding()
                    
                    NavigationLink(destination: TabbedView(isLoggedIn: $isLoggedIn).environmentObject(activityData), isActive: $isLoggedIn) { // Use isLoggedIn binding
                    }
                    .hidden()
                    
                    Button(action: {
                        // Perform login logic here
                        login()
                    }) {
                        Text("Login")
                            .padding()
                            .padding(.horizontal, 25)
                            .bold()
                            .background(.indigo)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    Spacer()
                }//vstack
                .padding()
                .onAppear {
                    
                    fetchRememberMe()
                    
                    // rememberme check
                    if rememberMe, let user = currentUser {
                        email = user.email
                        password = user.password
                        login()
                    }
                }// onappear - vstack
                .alert(isPresented: $showLoginPrompt) {
                    Alert(
                        title: Text("Invalid Credentials!"),
                        message: Text("Please check the user name and password"),
                        dismissButton: .default(Text("OK"))
                    )
                }//alert
                
            }
        }//navView
        
    }
    
    // Store rememberMe value in UserDefaults
    private func storeRememberMe() {
        UserDefaults.standard.set(rememberMe, forKey: "RememberMe")
    }
    
    // Fetch rememberMe value from UserDefaults on application launch
    private func fetchRememberMe() {
        rememberMe = UserDefaults.standard.bool(forKey: "RememberMe")
    }
    
    func login() {
        // Perform login validation and user authentication here
        
        // Example login validation:
        if email.isEmpty || password.isEmpty {
            self.showLoginPrompt = true
            // Show an alert or provide an error message to the user
            return
        }
        // user auth check
        if let user = usersDataSet.first(where: { $0.email == email && $0.password == password }) {
            //Success:
            
            // Load user preferences from UserDefaults
            if let preferencesData = UserDefaults.standard.data(forKey: "\(user.email)_Preferences"),
               let preferences = try? JSONDecoder().decode(UserPreferences.self, from: preferencesData) {
                user.preferences = preferences
            }
            
            // Save the currently logged in user to UserDefaults for persistence
            UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey: "CurrentUser")
            
            currentUser = user
            storeRememberMe()
            isLoggedIn = true
            email = ""
            password = ""
        }else{
            //ERROR: invalid login details, execute this
            self.showLoginPrompt = true
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
