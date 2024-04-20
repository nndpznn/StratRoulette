//
//  AuthorService.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/20/24.
//

import Foundation

import Firebase
import FirebaseAuthUI
import FirebaseEmailAuthUI

enum AuthorServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

class AuthorService: NSObject, ObservableObject, FUIAuthDelegate {
    private let db = Firestore.firestore()

//    @Published var currentAuthor: Author?
    
    func createAuthor(user: User) -> Author {
        
        db.collection("authors").document(user.uid).setData([
            "id": user.uid,
            "username": user.displayName ?? "user",
            "email": user.email ?? "none",
            "playlists": "",
        ])
        
        return Author(id: user.uid, username: user.displayName ?? "New User", email: user.email ?? "None", playlists: [])
    }
    
    func fetchAuthor(uid: String) async throws -> Author {
        let authorQuery = db.collection("authors")
        
        let querySnapshot = try await authorQuery.document(uid).getDocument()
          
        return querySnapshot.data().map { _ in
            let username = querySnapshot.get("username") as? String
            
            let email = querySnapshot.get("email") as? String ?? ""
            
            let playlists = querySnapshot.get("status") as? [Playlist] ?? []
            
            return Author(id: uid, username: username ?? "user", email: email, playlists: playlists)
            
        }!
    }
}
