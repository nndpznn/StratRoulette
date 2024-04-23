//
//  PlaylistDetail.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import SwiftUI

struct PlaylistList: View {
    @EnvironmentObject var challengeService: ChallengeService
    @EnvironmentObject var playlistService: PlaylistService
    
    @State var fetching: Bool = false
    
    @State var playlists: [Playlist] = [Playlist]()
    @State var error: Error?
    
    func updatePlaylists(){
        Task{
            playlists = try await playlistService.fetchPlaylists()
        }
    }
    
    func testPlaylistCreation(){
        playlistService.createPlaylist(playlist: examplePlaylist)
        return
    }
    
    var body: some View {
        NavigationStack{
            Button(action: testPlaylistCreation){
                Label("Create Example PLaylist", systemImage: "doc.fill.badge.plus")
            }
            if(playlists.count > 0){
                List(playlists, id: \.self){ playlist in
                    NavigationLink{
                        PlaylistDetail(playlist: playlist)
                    } label: {
                        HStack{
                            Text(playlist.playlistName)
                        }
                    }
                }
            }
            else{
                ProgressView()
            }
        }.onAppear(perform: updatePlaylists)
    }
}

//#Preview {
//    PlaylistDetail(playlist: examplePlaylist, challenges: [])
//}
