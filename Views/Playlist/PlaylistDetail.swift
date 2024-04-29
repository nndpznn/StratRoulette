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
    @EnvironmentObject var auth: StratAuth
    
    @Environment(\.dismiss) private var dismiss
    
    @State var fetching: Bool = false
    @State var editing: Bool = false
    
    var playlist: Playlist
    //var challenges: [Challenge]
    @State var error: Error?
    
    var body: some View {
        NavigationStack {
            ZStack{
                if(!editing){
                    VStack{
                        HStack{
                            VStack{
                                Text(playlist.playlistName)
                                    .font(.title)
                                    .padding(.bottom, 25)
                                if(playlist.authorID == auth.user?.uid){
                                    HStack{
                                        NavigationLink(destination: PlaylistEdit(oldPlaylist: playlist)
                                            .onDisappear(perform: {dismiss()})
                                            .onAppear(perform: {editing = true})) {
                                            Text("Edit Playlist")
                                                .foregroundStyle(.blue)
                                        }
                                        Button(action: {
                                            Task{
                                                await playlistService.deletePlaylist(playlistId: playlist.id)
                                                dismiss()
                                            }
                                        }) {
                                            Text("Delete Playlist")
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                        }
                        List(playlist.challenges, id: \.self) { challenge in
                            ChallengeItem(challenge:challenge)
                        }
                    }
                }
                else{
                    ProgressView()
                }
            }
        }
    }
}

//#Preview {
//    PlaylistDetail(playlist: examplePlaylist, challenges: [])
//}
