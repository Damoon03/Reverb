//
//  UserManager.swift
//  Reverb
//
//  Created by Damoon saber on 12/17/1404 AP.
//

import Foundation

@Observable
@MainActor
class UserManager {
    var currentUser: User?
    
    private let sercice: UserService
    init(service: UserService = UserService())  { 
        self.sercice = service
    }
    func fetchCurrentUser() async {
        do {
            self.currentUser = try await sercice.fetchCurrentUser()
        } catch {
            print("DEBUG: failed to fetch current user with error: \(error)")
        }
    }
}
