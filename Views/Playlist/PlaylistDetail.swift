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
        List(playlist.challenges, id: \.self) { challenge in
            Text(challenge)
        }
    }
}

#Preview {
    PlaylistDetail(playlist: examplePlaylist)
}
