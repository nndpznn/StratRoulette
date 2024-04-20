/**
 * BareBonesBlogAuth is an object that interacts with Firebase Authentication, allowing
 * it to keep track of user activities relating to login. It publishes its `user` variable
 * so that SwiftUI views will update when this variable changes.
 */
import Foundation

import Firebase
import FirebaseAuthUI
import FirebaseEmailAuthUI

class StratAuth: NSObject, ObservableObject, FUIAuthDelegate {
    var authorService: AuthorService = AuthorService()
    
    private let db = Firestore.firestore()
    @Published var error: Error?
    
    let authUI: FUIAuth? = FUIAuth.defaultAuthUI()

    // Multiple providers can be supported! See: https://firebase.google.com/docs/auth/ios/firebaseui
    let providers: [FUIAuthProvider] = [
        FUIEmailAuth()
    ]

    @Published var user: User?
    @Published var currentAuthor: Author?

    /**
     * You might not have overriden a constructor in Swift before...well, here it is.
     */
    override init() {
        super.init()

        // Note that authUI is marked as _optional_. If things don’t appear to work
        // as expected, check to see that you actually _got_ an authUI object from
        // the Firebase library.
        authUI?.delegate = self
        authUI?.providers = providers
    }

    /**
     * In another case of the documentation being somewhat behind the latest libraries,
     * this delegate method:
     *
     *     func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?)
     *
     * …has been deprecated in favor of the one below.
     */
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let actualResult = authDataResult {
            Task {
                do {
                    let docRef = db.collection("authors").document(actualResult.user.uid)
                    let newAuthor = try await docRef.getDocument()
                    if newAuthor.exists {
                        currentAuthor = try await authorService.fetchAuthor(uid: actualResult.user.uid)
                    } else {
                        currentAuthor = authorService.createAuthor(user: actualResult.user)
                    }
                }
                user = actualResult.user
            }
        }
    }

    func signOut() throws {
        try authUI?.signOut()

        // If we get past the logout attempt, we can safely clear the user.
        user = nil
        currentAuthor = nil
    }
}
