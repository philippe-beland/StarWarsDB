//
//  Droid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Droid: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var comments: String?
    
    init(id: String, name: String, comments: String?) {
        self.ID = id
        self.name = name
        self.comments = comments
    }
    
    static let example = Droid(id: "1", name: "R2 astromech droid", comments: "Astromech droid with a high degree of mechanical aptitude.")
}
