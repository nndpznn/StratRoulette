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
    @State var creating: Bool = false
    
    @State var playlists: [Playlist] = [Playlist]()
    @State var error: Error?
    
    //get list of playlists from database
    func updatePlaylists(){
        Task{
            print("Updating playlist list")
            playlists = try await playlistService.fetchPlaylists()
        }
    }
    
    //Tester function for playlist creation using the example playlist from EXAMPLEVALUES.swift
    func testPlaylistCreation(){
        playlistService.createPlaylist(playlist: examplePlaylist)
    }
    
    var body: some View {
        VStack{
            HStack{ //Upper button section
                Button("Create New Playlist", systemImage: "folder.fill.badge.plus") {
                    creating = true
                }.padding(.leading, 25)
            
                Spacer()
            
                Button(action: {
                    updatePlaylists()
                }) {
                    Label("Reload", systemImage: "arrow.triangle.2.circlepath.doc.on.clipboard")
                }.padding(.trailing, 25)
            }
            if(playlists.count > 0){ //playlist list
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
            else{ //displays loading wheel if we don't have playlists
                ProgressView()
            }
            Spacer()
        }
        .onAppear(perform: updatePlaylists) //Whenever this view appears, we want to update the playlists
        .sheet(isPresented: $creating) {  //When the user wants to create a new playlist, we show a sheet with the playlist creation view.  Importantly, we also update the playlists when this view disappears.  If we don't, the user has to manually hit the reload button for their playlist to appear in the list.
            CreatePlaylist(creating: $creating).onDisappear(perform: updatePlaylists)
        }
    }
}

//#Preview {
//    PlaylistDetail(playlist: examplePlaylist, challenges: [])
//}
