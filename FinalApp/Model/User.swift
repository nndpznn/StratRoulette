//
//  User.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    var id: String
    var username: String
    var email: String
    var playlists: [Playlist]
}
