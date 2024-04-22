//
//  ChallengeDetail.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

// Considering just letting the challenges sit on their own, without needing a greater detail page, just like they do on R6 Strat Roulette. 
import SwiftUI
import Firebase

struct ChallengeDetail: View {
    @EnvironmentObject var auth: StratAuth
    @EnvironmentObject var authorService: AuthorService
    @EnvironmentObject var challengeService: ChallengeService
    
    var db = Firestore.firestore()
    var challenge: Challenge
    
    @State var challengeAuthor: Author = exampleUser
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(.white)
                .frame(width:350,height:350)
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
                
                UserIcon(author: challengeAuthor)
            }
            .padding()
        }
        .task{
            do {
                challengeAuthor = try await authorService.fetchAuthor(uid: challenge.authorID)
            } catch {
                
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if auth.user != nil && auth.currentAuthor!.id == challenge.authorID {
                    Button("Delete Challenge") {
                        db.collection("challenges").document(challenge.id).delete()
                    }
                }
            }
        }
    }
}

#Preview {
    ChallengeDetail(challenge: exampleChallenge1)
        .environmentObject(AuthorService())
}

