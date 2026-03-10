//
//  ReverbApp.swift
//  Reverb
//
//  Created by Damoon saber on 12/8/1404 AP.
//

import Supabase
import SwiftUI

@main
struct ReverbApp: App {
    @State private var authManager = AuthManager()
    @State private var userManager = UserManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
                .environment(userManager)
        }
    }
}
