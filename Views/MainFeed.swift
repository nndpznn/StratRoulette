//
//  MainFeed.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/20/24.
//

import SwiftUI

struct MainFeed: View {
    @EnvironmentObject var auth: StratAuth
    @EnvironmentObject var challengeService: ChallengeService
    
    @State var challenges: [Challenge] = [exampleChallenge1, exampleChallenge2, exampleChallenge3]
    @State var writing: Bool = false
    
    var body: some View {
        VStack {
            Text("Challenge Feed")
                .font(.largeTitle)
                .bold()

            Button("New Challenge \(Image(systemName: "plus.circle"))") {
                writing = true
            }
            
            List(challenges) { challenge in
                ChallengeItem(challenge: challenge)
                    .environmentObject(AuthorService())
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .refreshable {
            do {
                challenges = try await challengeService.fetchChallenges()
            } catch {

            }
        }
        .sheet(isPresented: $writing) {
            CreateChallenge(challenges: $challenges, writing: $writing)
        }
        .task {
            do {
                challenges = try await challengeService.fetchChallenges()
            } catch {

            }
        }
    }
}

struct PostFeed_Preview: PreviewProvider {
//    @State static var requestLogin = false
    
    static var previews: some View {
        
        MainFeed()
        .environmentObject(StratAuth())
        .environmentObject(ChallengeService())

    }
}
