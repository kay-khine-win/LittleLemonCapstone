//
//  Home.swift
//  LittleLemon
//
//  Created by Kay Khine win on 16/5/23.
//

import SwiftUI
import CoreData


struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {

           // Add this line to declare a persistence constant and initialize it with the shared PersistenceController

        TabView{
            // Menu tab item
            Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)

                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                // Profile tab item
                UserProfile()
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
