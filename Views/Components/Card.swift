//
//  Card.swift
//  leakcheck
//
//  Created by Victor Lourme on 12/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct Card: View {
    @State public var status: String
    @State public var title: String
    @State public var startingColor: Color
    @State public var endingColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(status).fontWeight(.bold).font(.title).foregroundColor(.white)
            Text(title).foregroundColor(.white)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
        .overlay(RoundedRectangle(cornerRadius: 10))
        .foregroundColor(.clear)
        .background(LinearGradient(gradient: Gradient(colors: [
            startingColor,
            endingColor
        ]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .padding()
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(status: "0", title: "Title", startingColor: .orange, endingColor: .red)
    }
}
