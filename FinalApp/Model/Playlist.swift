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
    func toFirebaseDict() -> Dictionary<String, Any>{
        var rtn = Dictionary<String, Any>()
        rtn.updateValue(playlistName, forKey: "playlistName")
        var challs: [Dictionary<String, String>] = [Dictionary<String, String>]()
        for challenge in challenges{
            challs.append(challenge.toDictionary!)
        }
        rtn.updateValue(challs, forKey: "challenges")
        return rtn
    }
}

