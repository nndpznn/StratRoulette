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
                    .frame(width:325,height:90)
                    .shadow(radius: 1)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(challenge.title)
                            .font(.title2)
                            .bold()
                            .lineLimit(1)

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
                .padding(20)
            }
        }.preferredColorScheme(.light) //Overrides dark mode users so that we don't have white text on white background.  Credit to: https://medium.com/@_DandyLyons/how-to-add-apples-night-mode-to-your-swiftui-views-e172bb41dc94#:~:text=Dark%20Mode%20is%20built%20into,dark)%20.
    }
}

#Preview {
    ChallengeItem(challenge: exampleChallenge1)
        .environmentObject(StratAuth())
}
