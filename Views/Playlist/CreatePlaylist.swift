//
//  CreatePlaylist.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/17/24.
//

import SwiftUI

struct CreatePlaylist: View {
    @EnvironmentObject var auth: StratAuth
    @EnvironmentObject var challengeService: ChallengeService
    @EnvironmentObject var playlistService: PlaylistService
    
    @Environment(\.dismiss) private var dismiss //credit to: https://stackoverflow.com/questions/56513568/pop-or-dismiss-view-programmatically
    
    @Binding var creating: Bool
    @State var newTitle: String = ""
    @State var challenges: [Challenge] = [Challenge]()
    @State var selectedChallenges: [Challenge] = [Challenge]()
    @State var fetchingChallenges: Bool = false
    @State var newID: String = ""
    @State var saving: Bool = false
    
    //Grabs list of challenges from the database
    func updateChallengeList(){
        Task{
            fetchingChallenges = true
            challenges = try await challengeService.fetchChallenges()
            fetchingChallenges = false
        }
    }
    
    //Grabs the number of playlists from the database
    func updateNewID(){
        Task{
            let playlists = try await playlistService.fetchPlaylists()
            newID = String(playlists.count)
        }
    }
    
      
    
    
    var body: some View {
        VStack{
            TextField("Title", text: $newTitle)
            Spacer()
            if(fetchingChallenges || saving){  //Make sure to let the user know if we're talking to the database
                ProgressView()
            }
            else{
                List{ //Challenge List
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
                            HStack{ //Challenge List Item
                                Text(challenge.title)
                                Spacer()
                                if(selectedChallenges.contains(challenge)){ //Right-side icon should reflect selectedChallenges
                                    withAnimation{
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                                else{
                                    withAnimation{
                                        Image(systemName: "circle")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    }
                }
        
                Button("Done") { //Save and exit button - only enabled if the user has entered a title
                    if let user = auth.user{
                        playlistService.createPlaylist(playlist: Playlist(id: newID, playlistName: newTitle, authorID: user.uid, challenges: selectedChallenges))
                        saving = true
                        dismiss()
                    }
                }
                .disabled(newTitle.isEmpty)
            }
            
        }.padding(.horizontal, 25)
            .onAppear(perform: { //When this view is presented, grab all the data we need from the database
                updateChallengeList()
                updateNewID()
            })
    }
}

struct CreatePlaylist_Previews: PreviewProvider {
    @State static var creating = true
    
    static var previews: some View {
        CreatePlaylist(creating: $creating)
            .environmentObject(StratAuth())
            .environmentObject(ChallengeService())
            .environmentObject(PlaylistService())
    }
}
