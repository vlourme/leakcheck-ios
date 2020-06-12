//
//  TypeList.swift
//  leakcheck
//
//  Created by Victor Lourme on 12/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import Foundation

let types: [Type] = [
    // Basic types
    Type(title: "Email", description: "Lookup using a email", operation: "email"),
    Type(title: "Username", description: "Lookup using a username", operation: "login"),
    Type(title: "Keyword", description: "Lookup by keyword (keyword@*.*)", operation: "mass"),
    
    // Entreprise types
    Type(title: "Email by password", description: "Get emails using a password", operation: "pass_email", entreprise: true),
    Type(title: "Email by domain", description: "Get emails from a domain", operation: "domain_email", entreprise: true),
    Type(title: "Username by password", description: "Get username from a password", operation: "pass_login", entreprise: true),
    Type(title: "Email from hash", description: "Get email from hash (md5, sha1, sha256)", operation: "hash", entreprise: true)
]
