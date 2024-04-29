//
//  PlaylistEdit.swift
//  FinalApp
//
//  Created by Dylan Suzuki on 4/28/24.
//

import SwiftUI

struct PlaylistEdit: View {
    @EnvironmentObject var auth: StratAuth
    @EnvironmentObject var challengeService: ChallengeService
    @EnvironmentObject var playlistService: PlaylistService
    
    @Environment(\.dismiss) private var dismiss //credit to: https://stackoverflow.com/questions/56513568/pop-or-dismiss-view-programmatically
    let oldPlaylist: Playlist
    @State var newTitle: String = ""
    @State var challenges: [Challenge] = [Challenge]()
    @State var selectedChallenges: [Challenge] = [Challenge]()
    @State var fetchingChallenges: Bool = false
    @State var newID: String = ""
    @State var saving: Bool = false
    
    func updateChallengeList(){
        Task{
            fetchingChallenges = true
            challenges = try await challengeService.fetchChallenges()
            fetchingChallenges = false
        }
    }
    
    func importPlaylistData(){
        Task{
            await playlistService.deletePlaylist(playlistId: oldPlaylist.id)
        }
        newTitle = oldPlaylist.playlistName
        selectedChallenges = oldPlaylist.challenges
        newID = oldPlaylist.id
    }
    
      
    
    
    var body: some View {
        VStack{
            TextField("Title", text: $newTitle)
            Spacer()
            if(fetchingChallenges || saving){
                ProgressView()
            }
            else{
                List{
                    ForEach(challenges){ challenge in
                        Button(action: {
                            if(selectedChallenges.contains(challenge)){ //If the array already has the item, remove it
                                if let index = selectedChallenges.firstIndex(of: challenge){
                                    selectedChallenges.remove(at: index)
                                }
                            }
                            else{ //Otherwise, add the item
                                selectedChallenges.append(challenge)
                            }
                        }){
                            HStack{
                                Text(challenge.title)
                                Spacer()
                                if(selectedChallenges.contains(challenge)){
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .animation(.easeIn)
                                }
                                else{
                                    Image(systemName: "circle")
                                        .foregroundColor(.blue)
                                        .animation(.easeIn)
                                }
                            }
                        }
                    }
                }
        
                Button(action: {
                    if let user = auth.user{
                        playlistService.createPlaylist(playlist: Playlist(id: newID, playlistName: newTitle, authorID: user.uid, challenges: selectedChallenges))
                        saving = true
                        dismiss()
                    }
                }){
                    HStack{
                        Spacer()
                        Text("Done").padding(.all, 25)
                        Spacer()
                    }
                }
            }
            
        }.padding(.horizontal, 25)
            .onAppear(perform: {
                updateChallengeList()
                importPlaylistData()
            })
            .onDisappear(perform: {
                if(!saving){
                    playlistService.createPlaylist(playlist: oldPlaylist)
                }
            })
    }
}

//struct PlaylistEdit_Previews: PreviewProvider {
//    @State static var creating = true
//    
//    static var previews: some View {
//        PlaylistEdit(oldPlaylist: examplePlaylist)
//    }
//}

