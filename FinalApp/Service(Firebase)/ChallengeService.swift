//
//  ChallengeService.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/17/24.
//

import Foundation

import Firebase

let COLLECTION_NAME = "challenges"
let PAGE_LIMIT = 20

enum ChallengeServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

// DILEMMA: Do we use .document(id).setData, so we can fetch challenges by ID like we wanted to?
// Or, do we just use .addDocument? Can we still fetch these?
class ChallengeService: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var error: Error?
    
    func createChallenge(challenge: Challenge) -> String {
        var ref: DocumentReference? = nil
        
        ref = db.collection(COLLECTION_NAME).addDocument(data: [
            "id": challenge.id,
            "title": challenge.title,
            "description": challenge.description,
            "author": challenge.author
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
        
        return ref?.documentID ?? ""
    }
    
    func fetchChallenges() async throws -> [Challenge] {
        var challengeQuery = db.collection(COLLECTION_NAME)
            .limit(to: PAGE_LIMIT)
        
        do {
            let querySnapshot = try await challengeQuery.getDocuments()
            
            return try querySnapshot.documents.map {
                
                guard let id = $0.get("id") as? String,
                      let title = $0.get("title") as? String,
                      let description = $0.get("description") as? String,
                      let author = $0.get("author") as? Author
                else {
                    throw ChallengeServiceError.mismatchedDocumentError
                }
                
                return Challenge(
                    id: $0.documentID,
                    title: title,
                    description: description,
                    author: author
                )
            }
        } catch {
            print("error fetching posts: \(error)")
            throw error
        }
    }
    
    
}
