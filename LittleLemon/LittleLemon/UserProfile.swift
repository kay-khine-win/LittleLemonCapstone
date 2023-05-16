//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Kay Khine win on 16/5/23.
//

import SwiftUI

struct UserProfile: View {
    // Constants to hold user information from UserDefaults
       let firstName: String? = UserDefaults.standard.string(forKey: kFirstName)
       let lastName: String? = UserDefaults.standard.string(forKey: kLastName)
       let email: String? = UserDefaults.standard.string(forKey: kEmail)
    // Logout action
        func logout() {
            UserDefaults.standard.set(false, forKey: kIsLoggedIn)
            self.presentation.wrappedValue.dismiss()
        }
    
    // Presentation mode environment variable
       @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            Text("Personal Information")
                        .font(.title)
                        .padding()
            
            Image("profile")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
            
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            
            
            Button(action: {
                            logout()
                        }) {
                            Text("Logout")
                        }
            Spacer()
        }//Vstack
        .onAppear {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }
                }
       
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
