//
//  Organisation.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Organisation: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var comments: String?
    
    init(id: String, name: String, comments: String?) {
        self.ID = id
        self.name = name
        self.comments = comments
    }
    
    static let example = Organisation(id: "1", name: "Alphabet Squadron", comments: "The best squadron ever")
}
