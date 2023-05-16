//
//  Header.swift
//  LittleLemon
//
//  Created by Kay Khine win on 16/5/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
                  Image("logo") 
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(height: 100)
                      
              }//Vstack
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
