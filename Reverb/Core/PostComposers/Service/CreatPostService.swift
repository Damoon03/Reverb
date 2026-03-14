//
//  CreatPostService.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import Supabase
import Foundation

struct CreatPostService {
    private let client:  SupabaseClient
    
    init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey )
    }
    
    func creatPost(
        caption: String,
        authorID: String,
        authorUsername: String,
        authorProfileImageURL: String?
    ) async throws {
        let postId = UUID().uuidString
        let createdAt = Date()
        
        let post = post(
            id: postId,
            caption: caption,
            createdAt: createdAt,
            authorID: authorID,
            authorUsername: authorUsername,
            authorProfileImageURL: authorProfileImageURL
        )
        try await client.from("posts").insert(post).execute()
    }
}
