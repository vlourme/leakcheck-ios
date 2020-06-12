//
//  Settings.swift
//  leakcheck
//
//  Created by Victor Lourme on 11/06/2020.
//  Copyright © 2020 vlourme. All rights reserved.
//

import SwiftUI
import Foundation
import SafariServices

struct Settings: View {
    @State var isSafariOpen: Bool = false
    @State var safariUrl: String = ""
    
    @State var key: String = ""
    @State var ip: String = "xxx.xxx.xxx.xxx"
    @State var useMirror: Bool = false
    
    /// Set IP to the field
    func setIP() throws {
        // Start background task
        DispatchQueue.global(qos: .background).async {
            do {
                // Get IP
                self.ip = try Globals.client.getIP()
            } catch {
                self.ip = "Can't get IP"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("API Key").padding()
                
                Spacer()
                
                TextField("API Key", text: $key)
                    .padding()
            }
            
            HStack {
                Text("Your public IP").padding()
                
                Spacer()
                
                Text(ip)
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Toggle(isOn: $useMirror) {
                Text("Use mirror (leakcheck.io)")
            }.padding()
            
            HStack {
                Image("Author")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .mask(Circle()).foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text("Made by").font(.caption).foregroundColor(.white)
                    Text("Victor Lourme")
                        .font(.headline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .foregroundColor(.clear)
            .background(LinearGradient(gradient: Gradient(colors: [
                .blue,
                .purple
            ]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .padding()
            
            Button(action: {
                self.safariUrl = "https://github.com/vlourme/leakcheck-ios"
                self.isSafariOpen = true
            }) {
                Text("📚 Look the source code on GitHub").fixedSize(horizontal: false, vertical: true)
            }.padding()
            
            Button(action: {
                self.safariUrl = "https://leakcheck.io/?ref=225857"
                self.isSafariOpen = true
            }) {
                Text("❤️ Sign up on LeakCheck using my referral link").fixedSize(horizontal: false, vertical: true)
            }.padding()
            
            Form {
                EmptyView()
            }
            
            Spacer()
            
            Text("Don't forget to authorize your public IP on LeakCheck dashboard.").fixedSize(horizontal: false, vertical: true)
                .font(.callout)
                .padding()
            
            HStack(alignment: .top) {
                Button(action: {
                    // Save
                    Globals.settings.set(self.key, forKey: "key")
                    Globals.settings.set(self.useMirror, forKey: "useMirror")
                }) {
                    Text("Save settings").bold()
                }
                
                Spacer()
                
                Button(action: {
                    self.safariUrl = "https://leakcheck.net/"
                    self.isSafariOpen = true
                }) {
                    Text("Authorize in safari")
                }
            }.padding()
        }.onAppear() {
            // Load saved settings
            self.key = Globals.settings.string(forKey: "key") ?? ""
            self.useMirror = Globals.settings.bool(forKey: "useMirror")
            
            // Get IP
            do {
                try self.setIP()
            } catch {
                self.ip = "Can't get IP"
            }
        }.sheet(isPresented: $isSafariOpen, content: {
            SafariView(url:URL(string: self.safariUrl)!)
        })
    }
}

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
