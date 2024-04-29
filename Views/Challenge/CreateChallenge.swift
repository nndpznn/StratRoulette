//
//  CreateChallenge.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/17/24.
//

import SwiftUI

struct CreateChallenge: View {
    @EnvironmentObject var auth: StratAuth
    @EnvironmentObject var authorService: AuthorService
    @EnvironmentObject var challengeService: ChallengeService
    
    @Binding var writing: Bool
    
    @State var title = ""
    @State var description = ""
    
    func submitChallenge() {
        challengeService.createChallenge(challenge: Challenge(
            id: UUID().uuidString,
            title: title,
            description: description,
            authorID: auth.user!.uid
        ))
        
        writing = false
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    TextField("", text: $title)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(minHeight: 256, maxHeight: .infinity)
                }
            }
            .navigationTitle("Go on, challenge us!")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        writing = false
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        submitChallenge()
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                }
            }
        }
    }
}

struct CreateChallenge_Previews: PreviewProvider {
    @State static var writing = true
    
    static var previews: some View {
        CreateChallenge(writing: $writing)
            .environmentObject(StratAuth())
            .environmentObject(ChallengeService())
    }
}

