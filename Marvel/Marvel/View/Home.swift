//
//  Home.swift
//  Marvel
//
//  Created by User14 on 2022/12/27.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    var body: some View {
        TabView{
                    Characters()
                        .tabItem{
                            Image(systemName: "person.3.fill")
                            Text("Characters")
                        }
                        .environmentObject(homeData)
                    Comics()
                        .tabItem{
                            Image(systemName: "book.vertical.fill")
                            Text("Comics")
                        }.environmentObject(homeData)
                       
                    
                 }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
