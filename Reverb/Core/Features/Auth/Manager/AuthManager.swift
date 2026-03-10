//
//  AuthManager.swift
//  Reverb
//
//  Created by Damoon saber on 12/8/1404 AP.
//

import Foundation
import Observation

@Observable
@MainActor
class AuthManager {
    private let authService: SuperbaseAuthService
    
    var currentUserID: String?
    
    init(authService: SuperbaseAuthService = SuperbaseAuthService()) {
        self.authService = authService
    }
    
    func signUp(email: String, password: String, username: String) async {
        do {
            self.currentUserID = try await authService.signUp(email: email, password: password, username: username)
        } catch{
            print("SIGN UP ERROR: \(error.localizedDescription)")
        }
    }
   
    func signIn(email: String, password: String) async {
        do {
            self.currentUserID = try await authService.signIn(email: email, password: password)
        } catch{
            print("SIGN IN ERROR: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        do {
            try await authService.signOut()
            self.currentUserID = nil
        } catch {
            print("SIGN OUT ERROR: \(error.localizedDescription)")
        }
    }
    
    func refreshUser() async {
        do {
            self.currentUserID = try await authService.getCurrentUserSession()
        } catch {
            print("Refresh user error \(error)")
            currentUserID = nil
        }
    }
}

