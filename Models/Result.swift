//
//  Result.swift
//  leakcheck
//
//  Created by Victor Lourme on 12/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import Foundation

/// A Line Result
struct Result: Identifiable {
    let id = UUID()
    var username: String
    var password: String
    var sources: [String]
}
