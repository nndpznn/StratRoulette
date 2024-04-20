//
//  PlaylistDetail.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import SwiftUI

struct PlaylistDetail: View {
    var playlist: Playlist
    var body: some View {
        NavigationStack {
            List(playlist.challenges, id: \.self) { challenge in
                Text(challenge)
            }
            .navigationTitle(playlist.playlistName)
        }
    }
}

#Preview {
    PlaylistDetail(playlist: examplePlaylist)
}
