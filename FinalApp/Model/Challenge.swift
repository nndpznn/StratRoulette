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
    var author: User
}
