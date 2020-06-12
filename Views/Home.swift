//
//  Home.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    static public let api: API = API()
    
    @Environment(\.presentationMode) var presentationMode
    @State public var isModal: Bool = false
    @State private var title: String = "LeakCheck"
    
    var body: some View {
        NavigationView {
            TabView {
                Dashboard().tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }.onAppear(perform: {
                    self.title = "LeakCheck"
                })
                
                Search().tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.onAppear(perform: {
                    self.title = "Search"
                })
                
                Settings().tabItem {
                    Image(systemName: "person.fill")
                    Text("Settings")
                }.onAppear(perform: {
                    self.title = "Settings"
                })
                
            }
            .navigationBarTitle(title)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
