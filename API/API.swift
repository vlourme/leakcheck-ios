//
//  API.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import Just
import SwiftyJSON

extension String: Error {}

class API {
    /// Fetch every occurences for a username
    func fetch(input: String, type: String) throws -> [Result] {
        // Synchronize UserDefaults
        Globals.settings.synchronize()
        
        // Get key
        guard let key = Globals.settings.string(forKey: "key") else {
            throw "Please set an API key"
        }
        
        // Check for mirror usage
        var url = "https://leakcheck.net/api/"
        let mirror = Globals.settings.bool(forKey: "useMirror")
        if mirror {
            url = "https://leakcheck.io/api/"
        }
        
        // Make request
        let r = Just.get(url, params: [
            "key": key,
            "check": input,
            "type": type,
            "with_sources": 1
        ])
        
        // Check result
        if !r.ok {
            if r.statusCode == 429 {
                throw "API Rate Limit"
            } else {
                throw "Error processing request"
            }
        }
        
        // Prepare array
        var results = [Result]()
        
        // Parse JSON
        if let dataString = r.text?.data(using: .utf8, allowLossyConversion: false) {
            let json = try JSON(data: dataString)
            
            // Check success
            if !json["success"].boolValue {
                // Throw error
                throw json["error"].stringValue
            }
            
            // Append everything
            for item in json["result"].arrayValue {
                // Get line
                let line = item["line"].stringValue
                
                // Get sources
                let sources: [String] = item["sources"].arrayValue.map { $0.stringValue }
                
                // Split data
                let credentials = line.split(separator: ":")
                
                // Push in results
                results.append(Result(username: String(credentials[0]),
                                      password: String(credentials[1]),
                                      sources: sources))
            }
            
            // Return array
            return results
        }
        
        return results
    }
    
    /// Get checks and keywords consumed of the account
    func getLimits() throws -> (checks: Int, keywords: Int) {
        // Check for mirror usage
        var url = "https://leakcheck.net/api/"
        let mirror = Globals.settings.bool(forKey: "useMirror")
        if mirror {
            url = "https://leakcheck.io/api/"
        }
        
        // Synchronize UserDefaults
        Globals.settings.synchronize()
        
        // Get key
        guard let key = Globals.settings.string(forKey: "key") else {
            throw "Please set an API key"
        }
        
        
        // Make request
        let r = Just.get(url, params: [
            "key": key,
            "type": "limits"
        ])
        
        // Check result
        if !r.ok {
            if r.statusCode == 429 {
                throw "API Rate Limit"
            } else {
                throw "Error processing request"
            }
        }
        
        // Parse JSON
        if let dataString = r.text?.data(using: .utf8, allowLossyConversion: false) {
            let json = try JSON(data: dataString)
            
            // Check for error
            if !json["success"].boolValue {
                return (0, 0)
            }
            
            // Returns values
            return (json["limits"]["checks"].intValue, json["limits"]["keyword"].intValue)
        }
        
        return (0, 0)
    }
    
    /// Returns the IP from LeakCheck API
    func getIP() throws -> String {
        // Check for mirror usage
        var url = "https://leakcheck.net/ip"
        let mirror = Globals.settings.bool(forKey: "useMirror")
        if mirror {
            url = "https://leakcheck.io/ip"
        }
        
        // Make request
        let r = Just.post(url)
        
        // Check result
        if !r.ok {
            throw "Error processing request"
        }
        
        // Return IP
        return r.text!
    }
}
