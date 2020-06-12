//
//  Home.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State public var isModal: Bool = false
    @State private var title: String = "LeakCheck"
    
    @State private var checks: Int = 0
    @State private var keywords: Int = 0
    @State private var status: String = "Not linked"
    
    var body: some View {
        TabView {
            Dashboard(checks: checks, keywords: keywords, status: status).tabItem {
                Image(systemName: "house.fill")
                Text("Dashboard")
            }
            
            Search().tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            Settings().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            
        }.onAppear() {
            // Update default view
            do {
                // Make request
                let (checks, keywords) = try Globals.client.getLimits()
                
                // Fill values
                self.checks = checks
                self.keywords = keywords
                self.status = "Linked"
            } catch {
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
