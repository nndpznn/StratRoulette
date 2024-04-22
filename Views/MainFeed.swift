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
    
    var body: some View {
        List(challenges) { challenge in
            ChallengeItem(challenge: challenge)
                .environmentObject(AuthorService())
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
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
