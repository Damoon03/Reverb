//
//  UserProfileVIew.swift
//  Reverb
//
//  Created by Damoon saber on 12/15/1404 AP.
//

import SwiftUI

struct UserProfileVIew: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        NavigationStack {
            List {
                // header
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(userManager.currentUser?.username ?? "leading")
                            
                        Text(userManager.currentUser?.email ?? "")
                            .foregroundStyle(.secondary)
                        }
                    }
                    // sign out
                    Section {
                        Button("Sign out") {
                            Task { await authManager.signOut() }
                        }
                        .foregroundStyle(.red)
                    }
                }
                navigationTitle("profile")
            }
            .task { await userManager.fetchCurrentUser() }
        }
    }
    
    #Preview {
        UserProfileVIew()
    }
