//
//  CreatePlaylist.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/17/24.
//

import SwiftUI

struct CreatePlaylist: View {
    @EnvironmentObject var challengeService: ChallengeService
    @EnvironmentObject var playlistService: PlaylistService
    
    @State var newTitle: String = ""
    @State var challenges: [Challenge] = [Challenge]()
    @State var selectedChallenges: [Challenge] = [Challenge]()
    @State var fetching: Bool = false
    
    func updateChallengeList(){
        Task{
            fetching = true
            challenges = try await challengeService.fetchChallenges()
            fetching = false
        }
    }
    
    var body: some View {
        VStack{
            TextField("Title", text: $newTitle)
            Spacer()
            if(fetching){
                ProgressView()
            }
            else{
                List{
                    ForEach(challenges){ challenge in
                        Button(action: {
                            if(challenges.contains(challenge)){ //If the array already has the item, remove it
                                if let index = challenges.firstIndex(of: challenge){
                                    challenges.remove(at: index)
                                }
                            }
                            else{ //Otherwise, add the item
                                challenges.append(challenge)
                            }
                        }){
                            HStack{
                                Text(challenge.title)
                                Spacer()
                                if(challenges.contains(challenge)){
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
            }
            
        }.padding(.horizontal, 25)
    }
}

#Preview {
    CreatePlaylist()
}
