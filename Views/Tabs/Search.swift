//
//  Search.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI

struct Search: View {
    @State private var input: String = ""
    
    @State private var isError: Bool = false
    @State private var errorDescription: String = ""
    
    @State private var rows: [Result] = [Result]()
    
    @State private var selectedType: Int = 0
    
    @State private var isLoading: Bool = false
    
    func search() throws {
        // Clear array
        self.rows.removeAll()
        
        // Run in background
        DispatchQueue.global(qos: .background).async {
            do {
                // Make search
                self.rows = try Globals.client.fetch(input: self.input, type: types[self.selectedType].operation)
                
                // Unset error
                self.isError = false
            } catch (let error) {
                // Display error
                self.isError = true
                self.errorDescription = error as! String
            }
        }
        
        // Disable loading
        self.isLoading = false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Query", text: $input)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .disabled(isLoading)
                    
                    Button(action: {
                        // Set as loading
                        self.isLoading = true
                        
                        do {
                            try self.search()
                        } catch {
                            print(error)
                        }
                    }) {
                        Image(systemName: "magnifyingglass").font(.headline)
                    }
                    .padding()
                    .disabled(isLoading)
                }
                
                Form {
                    Section {
                        Picker(selection: $selectedType, label: Text("")) {
                            ForEach(0 ..< types.count, id: \.self) {
                                TypeSelector(type: types[$0])
                            }.navigationBarTitle("Select a method")
                        }
                        .disabled(isLoading)
                        .navigationBarTitle("Search")
                    }
                    
                    if isLoading {
                        Text("Loading, please wait...")
                    }
                    
                    if isError {
                        Text(errorDescription)
                    }
                    
                    if !isError && rows.count > 0 {
                        if (rows.count > 1) {
                            Text("\(rows.count) results")
                        } else {
                            Text("\(rows.count) result")
                        }
                    }
                    
                    if !isError {
                        List(rows) { row in
                            RowView(row: row)
                        }
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
