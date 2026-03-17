//
//  ContentView.swift
//  Reverb
//
//  Created by Damoon saber on 12/8/1404 AP.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        Group {
            if authManager.currentUserID != nil  {
                MainTabBar()
            } else {
                LoginView()
            }
        }
        .task { await authManager.refreshUser() }
        .task(id:authManager.currentUserID) {
            guard authManager.currentUserID != nil else { return }
            await userManager.fetchCurrentUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
        .environment(UserManager())
}
