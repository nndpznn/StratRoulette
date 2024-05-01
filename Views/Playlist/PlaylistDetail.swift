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
    
    @Environment(\.dismiss) private var dismiss //credit to: https://stackoverflow.com/questions/56513568/pop-or-dismiss-view-programmatically
    
    @State var fetching: Bool = false
    @State var editing: Bool = false
    @State var rolling: Bool = false
    @State var gettingRandom: Bool = false
    
    @State var currentChallenge: Int = 0
    
    var playlist: Playlist
    @State var error: Error?
    
    var body: some View {
        ZStack{
            if(!editing){
                VStack{
                    HStack{ //Title/button holder
                        VStack{
                            Text(playlist.playlistName)
                                .font(.title)
                                .bold()
                                .padding(.bottom, 10)
                            if(playlist.authorID == auth.user?.uid){ //Let authors delete and edit their own playlists
                                HStack{
                                    NavigationLink(destination: PlaylistEdit(oldPlaylist: playlist) //Edit button
                                        .onDisappear(perform: {dismiss()})
                                        .onAppear(perform: {editing = true})) {
                                            Text("Edit Playlist")
                                                .foregroundStyle(.blue)
                                        }
                                    Button(action: { //Delete button
                                        Task{
                                            await playlistService.deletePlaylist(playlistId: playlist.id)
                                            dismiss()
                                        }
                                    }) {
                                        Text("Delete Playlist")
                                            .foregroundStyle(.red)
                                    }
                                }.padding(.vertical, 15)
                            }
                            Button(action: { //Play button
                                print("Spinning the wheel")
                                Task{
                                    currentChallenge = try await getRandomNumber(count: playlist.challenges.count)
                                    print(currentChallenge)
                                    gettingRandom = true
                                    rolling = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                                        gettingRandom = false
                                    })
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .fill(.white)
                                        .frame(width:325,height:90)
                                        .shadow(radius: 1)
                                    VStack{
                                        HStack{
                                            Text("Play")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    List(playlist.challenges, id: \.self) { challenge in //Challenge List
                        ChallengeItem(challenge:challenge)
                    }.scrollContentBackground(.hidden)
                     .background(Color.clear)
                }
            }
            else{
                ProgressView()
            }
        }.sheet(isPresented: $rolling, content: { //Challenge sheet
            VStack{
                if(gettingRandom){ //For 2 seconds after the user hits play, the rouletteWheel will show up and spin
                    HStack{
                        ProgrammableShape()
                    }
                }
                else{  //After the wheel has done it's thing, we just display the challenge that was rolled
                    HStack{
                        Spacer()
                        Label("", systemImage: "arrow.down").padding(.top, 10)
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        Text("Prepare for...")
                            .font(.title)
                            .bold()
                        ChallengeDetail(challenge: playlist.challenges[currentChallenge])
                    }
                    Spacer()
                }
            }.onDisappear(perform: {rolling = false}) //Make sure to reset our booleans when the user dismisses the sheet
        })
    }
}

//#Preview {
//    PlaylistDetail(playlist: examplePlaylist, challenges: [])
//}
