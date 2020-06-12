//
//  Dashboard.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    @State public var checks: Int = 0
    @State public var keywords: Int = 0
    @State public var status: String = "Not linked"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
                Card(status: String(checks), title: "Checks left", startingColor: .pink, endingColor: .red)
                
                Card(status: String(keywords), title: "Keywords checks left", startingColor: .orange, endingColor: .red)
                
                Card(status: status, title: "API Key", startingColor: .yellow, endingColor: .orange)
                
                Spacer()
            }
        .navigationBarTitle("LeakCheck")
        }.onAppear(perform: {
            do {
                // Do request
                let (checks, keywords) = try Globals.client.getLimits()
                
                // Update
                self.checks = checks
                self.keywords = keywords
                self.status = "Linked"
            } catch {
                
            }
        })
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
