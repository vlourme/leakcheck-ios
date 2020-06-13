//
//  CompleteRowView.swift
//  leakcheck
//
//  Created by Victor Lourme on 12/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct CompleteRowView: View {
    @State public var row: Result
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Username").padding()
                
                Spacer()
                
                Text(row.username).bold().padding()
            }
            
            HStack {
                Text("Password").padding()
                
                Spacer()
                
                Text(row.password).bold().padding()
            }
            
            Form {
                Section(header: Text("Sources")) {
                    if row.sources.count > 0 {
                        List {
                            ForEach(0 ..< row.sources.count, id: \.self) {
                                Text(self.row.sources[$0])
                            }
                        }
                    } else {
                        Text("Unknown source")
                    }
                }
            }
                
            .navigationBarTitle("Result")
            .navigationBarItems(trailing: Button(action: {
                let items = ["\(self.row.username):\(self.row.password)"]
                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true, completion: nil)
            }) {
                Image(systemName: "square.and.arrow.up")
            }.font(.headline))
        }
    }
}

struct CompleteRowView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteRowView(row: Result(username: "username", password: "password", sources: ["example.com"]))
    }
}
