//
//  SuperbaseAuthService.swift
//  Reverb
//
//  Created by Damoon saber on 12/8/1404 AP.
//

import Foundation
import Supabase

struct SuperbaseAuthService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey)
    }
    
    func signUp(email: String, password: String, username: String) async throws -> String {
        let response = try await client.auth.signUp(email: email, password: password)
        print(response.user)
        let uid = response.user.id.uuidString
        try await uploadUserData(with: uid, email: email, userName: username)
        return uid
    }
    
    func signIn(email: String, password: String) async throws -> String {
        let response = try await client.auth.signIn(email: email, password: password)
        print(response.user )
        return response.user.id.uuidString
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUserSession() async throws -> String? {
        let supabsseUser = try await client.auth.session.user
        return supabsseUser.id.uuidString
    }
    
    private func uploadUserData(with uid: String, email: String, userName: String ) async throws {
        let user = User(id: uid, email: email, username: userName, createdAt: Date(), postCount: 0 )
        try await client.from("users").insert(user).execute()
    } 
}
