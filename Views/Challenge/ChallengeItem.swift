//
//  ChallengeItem.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/17/24.
//

import SwiftUI

struct ChallengeItem: View {
    var challenge: Challenge
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(.white)
                .frame(width:350,height:100)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(challenge.title)
                        .font(.title)
                        .bold()
                    Text(challenge.description)
                        .font(.callout)
                        .lineLimit(1)
                }
                Spacer()
                
                
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.gray)
            }
            .padding(40)
        }
    }
}

#Preview {
    ChallengeItem(challenge: exampleChallenge1)
}
