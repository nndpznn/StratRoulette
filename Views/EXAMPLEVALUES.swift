//
//  EXAMPLEVALUES.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import Foundation

var exampleUser = Author(id:"0001", username: "nndpznn", email: "nolan2087@gmail.com", playlists: [examplePlaylist])

var exampleChallenge1 = Challenge(id:"0001", title: "A Little Sus", description: "Only use AmongUs-related callouts in the last encounter of Vault of Glass.", author: exampleUser)

var exampleChallenge2 = Challenge(id:"0002", title: "Back to Basics", description: "All fireteam members are banned from using exotics for the duration of this encounter.", author: exampleUser)

var exampleChallenge3 = Challenge(id:"0003", title: "The Uchiha Survive", description: "You must leave Sheldon and Shashuke alive, as well as ALL of their friends!", author: exampleUser)


var examplePlaylist = Playlist(playlistName:"Nolan's Faves", challenges: [
    "0001",
    "0002",
    "0003"
])
