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
            print("Updating playlist list")
            playlists = try await playlistService.fetchPlaylists()
        }
    }
    
    func testPlaylistCreation(){
        playlistService.createPlaylist(playlist: examplePlaylist)
        return
    }
    
    var body: some View {
        VStack{
            HStack{
                NavigationLink(destination: CreatePlaylist().onDisappear(perform: updatePlaylists)){
                    Label("Create New Playlist", systemImage: "folder.fill.badge.plus")
                }.padding(.leading, 25)
                Spacer()
                Button(action: {
                    updatePlaylists()
                }) {
                    Label("Reload", systemImage: "arrow.triangle.2.circlepath.doc.on.clipboard")
                }.padding(.trailing, 25)
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
            Spacer()
        }.onAppear(perform: updatePlaylists)
    }
}

//#Preview {
//    PlaylistDetail(playlist: examplePlaylist, challenges: [])
//}
