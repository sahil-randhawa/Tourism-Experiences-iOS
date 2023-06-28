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
        User(email: "a", password: "1", favourites: []),
        User(email: "vaisrav@gmail.com", password: "12345", favourites: []),
        User(email: "sahil@gmail.com", password: "12345", favourites: [])
    ]
    
    // currently logged user
    @State private var currentUser : User = User()
    
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
                    
                    NavigationLink(destination: TabbedView(isLoggedIn: $isLoggedIn).environmentObject(currentUser).environmentObject(activityData), isActive: $isLoggedIn) { // Use isLoggedIn binding
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
                    
                    if (UserDefaults.standard.string(forKey: "KEY_CurrentUserEmail") != "") {
                        let userDataEmail = UserDefaults.standard.string(forKey: "KEY_CurrentUserEmail")
                        currentUser = usersDataSet.first(where: ({$0.email == userDataEmail})) ?? User()
                    }
                    fetchRememberMe()
                    
                    // rememberme check
                    if rememberMe {
                        email = currentUser.email
                        password = currentUser.password
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
        .navigationBarBackButtonHidden(true)
        
    }
    
    // Store rememberMe value in UserDefaults
    private func storeRememberMe() {
        UserDefaults.standard.set(rememberMe, forKey: "KEY_RememberMe")
    }
    
    // Fetch rememberMe value from UserDefaults on application launch
    private func fetchRememberMe() {
        rememberMe = UserDefaults.standard.bool(forKey: "KEY_RememberMe")
    }
    
    func login() {
        // Perform login validation and user authentication here
        
        if email.isEmpty || password.isEmpty {
            // Show an alert or provide an error message to the user
            self.showLoginPrompt = true
            return
        }
        // user auth check
        if let user:User = usersDataSet.first(where: { $0.email == email && $0.password == password }) {
            //Success:
            
            // Load user preferences from UserDefaults
            if let userFavList = UserDefaults.standard.array(forKey: "KEY_\(user.email)_Preferences") as? [String]{
                user.favorites = userFavList
            }
            
            // Save the currently logged in user to UserDefaults for persistence
            UserDefaults.standard.set(user.email, forKey: "KEY_CurrentUserEmail")
            
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
