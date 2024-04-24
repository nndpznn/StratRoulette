//
//  Challenge.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import Foundation

struct Challenge: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var authorID: String
}

//Credit to: https://stackoverflow.com/questions/55750619/how-to-store-custom-object-in-firebase-with-swift#:~:text=There%20are%20no%20custom%20objects,%27feel%27%20like%20you%20are.
extension Encodable {
    var toDictionary: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String]
    }
}
