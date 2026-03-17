//
//  FeedService.swift
//  Reverb
//
//  Created by Damoon saber on 12/26/1404 AP.
//

import Foundation
import Supabase

struct FeedService {
    private let client:  SupabaseClient
    
    init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey )
    }
 
    func fetchPost() async throws -> [post] {
        return try await client
            .from("posts")
            .select()
            .order("createdAt", ascending: false)
            .execute()
            .value
    }
}
