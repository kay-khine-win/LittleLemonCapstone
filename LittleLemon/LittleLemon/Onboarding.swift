//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Kay Khine win on 16/5/23.
//
let kFirstName = "first_name"
let kLastName = "last_name"
let kEmail = "email"
// Login constant
let kIsLoggedIn = "kIsLoggedIn"
let isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
    
import SwiftUI

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
   @State private var email = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
        VStack{
            Header()
                .padding(.bottom, 30)
            NavigationLink(destination: Home(), isActive: $isLoggedIn) {}
                .padding(.bottom, 30)
            Text("First Name *")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 0)
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, 20)
                .padding(.bottom, 30)
            
            
            Text("Last Name *") .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 0)
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, 20)
                .padding(.bottom, 30)
            
            Text("Email *")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 0)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, 20)
                .padding(.bottom, 30)
            
            Button("Register") {
                if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                    
                    firstName = ""
                    lastName = ""
                    email = ""
                    
                    // Set isLoggedIn to true
                    isLoggedIn = true
                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            
                }
            }
        }
    }
        
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
