//
//  Arc.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Arc: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    
    init(id: String, name: String) {
        self.ID = id
        self.name = name
    }
    
    static let example = Arc(id: "1", name: "Battle for the Force")
    
}
