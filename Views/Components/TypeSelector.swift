//
//  TypeSelector.swift
//  leakcheck
//
//  Created by Victor Lourme on 12/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct TypeSelector: View {
    @State public var type: Type
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(type.title)
                Text(type.description).font(.caption)
            }
            
            Spacer()
            
            if type.entreprise {
                Image(systemName: "dollarsign.circle")
            }
        }
    }
}

struct TypeSelector_Previews: PreviewProvider {
    static var previews: some View {
        TypeSelector(type: types[4])
    }
}
