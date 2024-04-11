//
//  Playlist.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import Foundation

struct Playlist: Hashable, Codable {
    var playlistName: String
    var challenges: [String]
}
