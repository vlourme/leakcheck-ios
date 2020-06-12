//
//  Row.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import Foundation

struct Row: Identifiable {
    let id = UUID()
    var username: String
    var password: String
}
