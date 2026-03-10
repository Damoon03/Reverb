//
//  UserService.swift
//  Reverb
//
//  Created by Damoon saber on 12/17/1404 AP.
//

import Foundation
import Supabase

struct UserService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey)
    }
    
    func fetchCurrentUser() async throws -> User {
        let user = try await client.auth.session.user
        
        return try await client.from("users")
            .select()
            .eq("id" , value: user.id.uuidString)
            .single()
            .execute()
            .value
    }
}
