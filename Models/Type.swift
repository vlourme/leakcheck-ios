//
//  Type.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import Foundation

struct Type: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var operation: String
    var entreprise: Bool = false
}
