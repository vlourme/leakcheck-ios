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
                Text("Result").font(.title).bold().padding()
                
                Spacer()
                
                Button(action: {
                    let items = ["\(self.row.username):\(self.row.password)"]
                    let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true, completion: nil)
                }) {
                    Image(systemName: "square.and.arrow.up")
                }.padding().font(.headline)
            }
            
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
                if row.sources.count > 0 {
                    Section(header: Text("Sources")) {
                        List {
                            ForEach(0 ..< row.sources.count, id: \.self) {
                                Text(self.row.sources[$0])
                            }
                        }
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}

struct CompleteRowView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteRowView(row: Result(username: "username", password: "password", sources: ["example.com"]))
    }
}
