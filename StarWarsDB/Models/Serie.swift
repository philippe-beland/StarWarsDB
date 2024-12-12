//
//  Serie.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Serie: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var comments: String?
    
    init(id: String, name: String, comments: String?) {
        self.ID = id
        self.name = name
        self.comments = comments
    }
    
    static let example = Serie(id: "1", name: "Star Wars Rebels", comments: "Series about the adventures of Ghost Squadron")
}
