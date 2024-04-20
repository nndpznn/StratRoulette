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
    
    var body: some View {
        Text("This is the main feed!")
    }
}

#Preview {
    MainFeed()
        .environmentObject(StratAuth())
}
