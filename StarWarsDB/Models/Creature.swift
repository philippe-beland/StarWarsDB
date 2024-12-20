//
//  Creature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Creature: Entity {
    var homeworld: Planet?
    var firstAppearance: String?
    
    init(name: String, homeworld: Planet?, image: String?, firstAppearance: String?, comments: String = "") {
        self.homeworld = homeworld
        self.firstAppearance = firstAppearance
        
        super.init(name: name, comments: comments, image: image, recordType: "Creature", tableName: "creatures")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Creature(name: "Dianoga", homeworld: .example, image: "Dianoga", firstAppearance: nil)
}
