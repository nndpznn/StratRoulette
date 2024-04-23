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

extension Encodable {
    var toDictionary: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String]
    }
}
