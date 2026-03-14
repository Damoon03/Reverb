//
//  SuperbaseStorsgeManager.swift
//  Reverb
//
//  Created by Damoon saber on 12/22/1404 AP.
//

import Foundation
import Supabase

struct SuperbaseStorageManager {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey)
    }
    func uploadProfilePhoto(for user: User, imageData: Data) async throws -> String {
        let path = "\(user.id)/avatar.jpg"
        
        try await client.storage
            .from("avatars")
            .upload(path, data:imageData)
        
        let publicURL = try client.storage.from("avatars").getPublicURL(path: path)
        
        print("DEBUG: public url is \(publicURL.absoluteString)")
        
        return publicURL.absoluteString
    }
}
 
