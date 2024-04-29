//
//  PlaylistService.swift
//  FinalApp
//
//  Created by Dylan Suzuki on 4/22/24.
//

import Foundation

import Firebase

let PLAYLIST_COLLECTION_NAME = "playlists"

enum PlaylistServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

// DILEMMA: Do we use .document(id).setData, so we can fetch challenges by ID like we wanted to?
// Or, do we just use .addDocument? Can we still fetch these?
class PlaylistService: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var error: Error?
    
    func parsePlaylistChallenges(playlist: Playlist) -> [Dictionary<String, String>]{
        var rtn = [Dictionary<String, String>]()
        
        for challenge in playlist.challenges{
            rtn.append(challenge.toDictionary ?? Dictionary<String, String>())
        }
        
        return rtn
    }
    
    func parseDBChallenges(dictionaries: [Dictionary<String, String>]) -> [Challenge]{
        var rtn = [Challenge]()
        
        for challenge in dictionaries{
            rtn.append(Challenge(id: challenge["id"]!, title: challenge["title"]!, description: challenge["description"]!, authorID: challenge["authorID"]!))
        }
        
        return rtn
    }
    
    func createPlaylist(playlist: Playlist) -> Void {
//        var ref: DocumentReference? = nil
        
        db.collection(PLAYLIST_COLLECTION_NAME).addDocument(data: [
            "playlistName": playlist.playlistName,
            "id": playlist.id,
            "authorID": playlist.authorID,
            "challenges": parsePlaylistChallenges(playlist: playlist),
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
        
        return
    }
    
    func fetchPlaylists() async throws -> [Playlist] {
        let playlistQuery = db.collection(PLAYLIST_COLLECTION_NAME)
            .limit(to: PAGE_LIMIT)
        
        do {
            let querySnapshot = try await playlistQuery.getDocuments()
            
            return try querySnapshot.documents.map {
                
                guard let name = $0.get("playlistName") as? String,
                      let id = $0.get("id") as? String,
                      let authorID = $0.get("authorID") as? String,
                      let challengeList = $0.get("challenges") as? [Dictionary<String, String>]
                else {
                    throw PlaylistServiceError.mismatchedDocumentError
                }
                
                let challenges = parseDBChallenges(dictionaries: challengeList)
                
                return Playlist(
                    id: id,
                    playlistName: name,
                    authorID: authorID,
                    challenges: challenges
                )
            }
        } catch {
            print("error fetching posts: \(error)")
            throw error
        }
    }
    
//    func fetchChallenge(uid: String) async throws -> Challenge {
//        let challengeQuery = db.collection(COLLECTION_NAME)
//
//        let querySnapshot = try await challengeQuery.document(uid).getDocument()
//
//        return querySnapshot.data().map { _ in
//            let id = querySnapshot.get("id") as? String ?? "No ID"
//
//            let title = querySnapshot.get("title") as? String ?? "Not Found"
//
//            let description = querySnapshot.get("description") as? String ?? ""
//
//            let author = querySnapshot.get("author") as! Author
//
//            return Challenge(id:id, title:title, description:description, author:author)
//        }!
//    }
}
