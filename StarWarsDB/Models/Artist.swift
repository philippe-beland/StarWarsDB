//
//  Artist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Artist: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    
    init(id: String, name: String) {
        self.ID = id
        self.name = name
    }
    
    static let example = Artist(id: "1", name: "Charles Soule")
    
}
