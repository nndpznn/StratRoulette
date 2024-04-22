//
//  PlaylistDetail.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import SwiftUI

struct PlaylistDetail: View {
    @EnvironmentObject var challengeService: ChallengeService
    
    @State var fetching: Bool = false
    
    var playlist: Playlist
    var challenges: [Challenge]
    @State var error: Error?
    
    var body: some View {
        Text("Pain.")
//        NavigationStack {
//            List(playlist.challenges, id: \.self) { challenge in
//                Task {
//                    do {
//                        self.error = nil
//                        fetching = true
//                        challenges.append( try await challengeService.fetchChallenge(uid: challenge))
//                        fetching = false
//                    } catch {
//                        self.error = error
//                        fetching = false
//                    }
//                }
////                ChallengeItem(challenge: currentChallenge)
//            }
//            .navigationTitle(playlist.playlistName)
//        }
    }
}

#Preview {
    PlaylistDetail(playlist: examplePlaylist, challenges: [])
}
