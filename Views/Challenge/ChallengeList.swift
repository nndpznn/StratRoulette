//
//  ChallengeList.swift
//  FinalApp
//
//  Created by Dylan Suzuki on 4/17/24.
//
// Probably won't be used in the final but for now I'm using this to test the database

import SwiftUI

struct ChallengeList: View {
    @EnvironmentObject var auth: StratAuth
    @EnvironmentObject var db: StratDB
    
    @State var challenges: [Challenge] = [Challenge]()
    @State var fetching: Bool = true
    var body: some View {
        VStack{
            if fetching{
                ProgressView()
            }
            else if challenges.count == 0{
                Spacer()
                Text("NO CHALLENGES")
                Spacer()
            }
            else{
                List(challenges){ challenge in
                    Text(challenge.title)
                }
            }
        }.onAppear(perform: {
            Task{
                do{
                    challenges = try await db.fetchChallenges()
                    fetching = false
                }
                catch{
                    print(error)
                    fetching = false
                }
            }
        })
    }
}

#Preview {
    ChallengeList()
}
