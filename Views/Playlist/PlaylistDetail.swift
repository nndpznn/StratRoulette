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
    @State var rolling: Bool = false
    @State var gettingRandom: Bool = false
    
    @State var currentChallenge: Int = 0
    @State private var wheelRotation: Bool = false
    
    var animation: Animation {
        Animation.easeOut
    }
    
    var playlist: Playlist
    //var challenges: [Challenge]
    @State var error: Error?
    
    var body: some View {
        ZStack{
            if(!editing){
                VStack{
                    HStack{
                        VStack{
                            Text(playlist.playlistName)
                                .font(.title)
                                .padding(.bottom, 10)
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
                                }.padding(.vertical, 15)
                            }
                            Button(action: {
                                print("Spinning the wheel")
                                Task{
                                    currentChallenge = try await getRandomNumber(count: playlist.challenges.count)
                                    print(currentChallenge)
                                    gettingRandom = true
                                    rolling = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                                        gettingRandom = false
                                        self.wheelRotation.toggle()
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
                    List(playlist.challenges, id: \.self) { challenge in
                        ChallengeItem(challenge:challenge)
                    }.scrollContentBackground(.hidden)
                     .background(Color.clear)
                }
            }
            else{
                ProgressView()
            }
        }.sheet(isPresented: $rolling, content: {
            VStack{
                if(gettingRandom){
                    HStack{
                        ProgrammableShape()
                    }
                }
                else{
                    HStack{
                        Spacer()
                        Label("", systemImage: "arrow.down").padding(.top, 10)
                        Spacer()
                    }
                    Spacer()
                    ChallengeDetail(challenge: playlist.challenges[currentChallenge])
                    Spacer()
                }
            }.onDisappear(perform: {rolling = false})
        })
    }
}

//#Preview {
//    PlaylistDetail(playlist: examplePlaylist, challenges: [])
//}
