//
//  ChallengeDetail.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

// Considering just letting the challenges sit on their own, without needing a greater detail page, just like they do on R6 Strat Roulette. 
import SwiftUI

struct ChallengeDetail: View {
    var challenge: Challenge
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(.white)
                .frame(width:375,height:350)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text(challenge.title)
                    .font(.title)
                    .bold()
                Divider()
                
                Text(challenge.description)
                    .padding()
                    
                
                Text("Submitted by:")
                    .font(.title2)
                    .bold()
                
                UserIcon(author: challenge.author)
            }
        }
    }
}

#Preview {
    ChallengeDetail(challenge: exampleChallenge1)
}

