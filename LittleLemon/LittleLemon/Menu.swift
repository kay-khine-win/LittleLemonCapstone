//
//  Menu.swift
//  LittleLemon
//
//  Created by Kay Khine win on 16/5/23.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Dish.entity(), sortDescriptors: []) var dishes: FetchedResults<Dish>

    var body: some View {
        VStack {
            Header()
            Text("Little Lemon App")
                .font(.title)
                .padding()

            Text("Chicago")
                .font(.headline)
                .padding()

            HStack{
                Text("Order delicious food from Little Lemon. Browse our menu, customize your order, and enjoy convenient delivery.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Image("salmon") // Replace "logo" with the name of your logo image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }

            List {
                ForEach(dishes) { dish in
                    HStack {
                        if let title = dish.title, let price = dish.price {
                            Text("\(title) - \(price)")
                        }
                        AsyncImage(url: URL(string: dish.image ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                    }
                }
            }//List
        }//VStack
        .onAppear {
            getMenuData()
        }
    }
    
static func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }

    func getMenuData() {
        PersistenceController.shared.clear()

        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching menu data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let menuList = try decoder.decode(MenuList.self, from: data)

                DispatchQueue.main.async {
                    for menuItem in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        // Set other properties as needed

                        // Save the dish to the database
                        do {
                            try viewContext.save()
                        } catch {
                            print("Error saving dish: \(error.localizedDescription)")
                        }
                    }
                }
            } catch {
                print("Error decoding menu data: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
