//
//  Dashboard.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    @State private var checks: Int = 0
    @State private var keywords: Int = 0
    @State private var status: String = "Not linked"
    
    func update() throws {
        // Make request
        do {
            // Do request
            let (checks, keywords) = try Globals.client.getLimits()
            
            // Set
            self.checks = checks
            self.keywords = keywords
            self.status = "Linked"
        }
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            Card(status: String(checks), title: "Checks left", startingColor: .pink, endingColor: .red)
            
            Card(status: String(keywords), title: "Keywords checks left", startingColor: .orange, endingColor: .red)
            
            Card(status: status, title: "API Key", startingColor: .yellow, endingColor: .orange)
            
            Spacer()
        }.onAppear(perform: {
            do {
                try self.update()
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
