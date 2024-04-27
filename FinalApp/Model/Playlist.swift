//
//  Playlist.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import Foundation

struct Playlist: Hashable, Codable, Identifiable {
    var id: String
    var playlistName: String
    var challenges: [Challenge]
}
