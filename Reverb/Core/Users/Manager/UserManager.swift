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
    func updateProfileImageURL(_ imageURL: String) async {
        do {
            try await sercice.updateProfileImageURL(imageURL)
            self.currentUser?.profileImageURL = imageURL
        } catch {
            print("DEBUG: failed to update user profile image url with error:\(error)")
        }
    }
}
