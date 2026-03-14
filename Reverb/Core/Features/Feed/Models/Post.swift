//
//  Post.swift
//  Reverb
//
//  Created by Damoon saber on 12/23/1404 AP.
//

import Foundation

struct post: Identifiable, Codable {
    let id: String
    let caption: String
    let createdAt: Date
    let authorID: String
    let authorUsername: String
    let authorProfileImageURL: String?
}
