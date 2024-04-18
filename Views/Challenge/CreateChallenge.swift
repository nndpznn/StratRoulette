//
//  CreateChallenge.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/17/24.
//

import SwiftUI

struct CreateChallenge: View {
    @EnvironmentObject var auth: StratAuth
    @EnvironmentObject var challengeService: ChallengeService
    
    @Binding var challenges: [Challenge]
    @Binding var writing: Bool
    
    @State var title = ""
    @State var description = ""
    
//    func submitChallenge() {
//        let challengeID = challengeService.createChallenge(challenge: Challenge(
//            id: UUID().uuidString,
//            title: title,
//            description: description,
//            author: // Fetch author.
//        ))
//        
//    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CreateChallenge()
}
