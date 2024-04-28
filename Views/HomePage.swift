//
//  HomePage.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/20/24.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var auth: StratAuth
    
    var body: some View {
        TabView {
            MainFeed()
                .tabItem {
                    Label("Feed", systemImage: "list.bullet")
                }
            PlaylistList()
                .tabItem {
                    Label("Playlists", systemImage: "list.bullet")
                }
            Profile(challenges: [])
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    HomePage()
        .environmentObject(StratAuth())
}
