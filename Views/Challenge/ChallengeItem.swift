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
        NavigationLink {
            ChallengeDetail(challenge: challenge)
                .environmentObject(AuthorService())
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(.white)
                    .frame(width:350,height:90)
                    .shadow(radius: 1)
                
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
                    
                    
                    Image(systemName: "chevron.right.square")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.gray)
                }
                .padding(40)
            }
        }.preferredColorScheme(.light) //Overrides dark mode users so that we don't have white text on white background
    }
}

#Preview {
    ChallengeItem(challenge: exampleChallenge1)
        .environmentObject(StratAuth())
}
