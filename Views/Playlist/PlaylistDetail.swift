//
//  PlaylistDetail.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import SwiftUI

struct PlaylistDetail: View {
    @EnvironmentObject var challengeService: ChallengeService
    @EnvironmentObject var playlistService: PlaylistService
    
    @State var fetching: Bool = false
    
    var playlist: Playlist
    //var challenges: [Challenge]
    @State var error: Error?
    
    var body: some View {
        ZStack{
            VStack{
                Text(playlist.playlistName)
                    .font(.title)
                List(playlist.challenges, id: \.self) { challenge in
                    HStack{
                        Text(challenge.title)
                    }
                }
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
    }
}

//#Preview {
//    PlaylistDetail(playlist: examplePlaylist, challenges: [])
//}
