//
//  User.swift
//  Reverb
//
//  Created by Damoon saber on 12/9/1404 AP.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let createdAt: Date
    var profileImageURL: String? = nil
}
