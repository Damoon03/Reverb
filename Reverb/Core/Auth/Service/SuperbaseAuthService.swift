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
    
    func signUp(email: String, password: String) async throws {
        
    }
    
    func signIn(email: String, password: String) async throws {
        
    }
    
    func signOut() async throws {
        
    }
}
