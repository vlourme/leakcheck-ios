//
//  RowView.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct RowView: View {
    var row: Result
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(row.username):\(row.password)").fixedSize(horizontal: false, vertical: true)
            }
            if row.sources.count > 0 {
                Text(row.sources.joined(separator: ", ")).font(.subheadline).foregroundColor(.gray)
            } else {
                Text("Unknown source").font(.subheadline).foregroundColor(.gray)
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(row: Result(username: "username",
                            password: "password",
                            sources: ["example.com"]))
    }
}
