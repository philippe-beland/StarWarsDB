//
//  Creature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Creature: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var homeworld: Planet?
    
    var url: URL?
    
    init(id: String, name: String, homeworld: Planet?, url: URL?) {
        self.ID = id
        self.name = name
        self.homeworld = homeworld
        self.url = url
        
    }
    
    static let example = Creature(id: "1", name: "Dianoga", homeworld: .example, url: nil)
    
}
