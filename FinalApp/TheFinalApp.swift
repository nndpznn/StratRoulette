//
//  FinalAppApp.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/3/24.
//

import SwiftUI

@main
struct TheFinalApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(StratAuth())
                .environmentObject(ChallengeService())
                .environmentObject(AuthorService())
        }
    }
}
