//
//  Species.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Species: Entity {
    var homeworld: Planet?
    var firstAppearance: String?
    
    init(name: String, homeworld: Planet?, firstAppearance: String?, image: String?, comments: String = "") {
        self.homeworld = homeworld
        self.firstAppearance = firstAppearance
        
        super.init(name: name, comments: comments, image: image, recordType: "Species", tableName: "species")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Species(name: "Twi'lek", homeworld: .example, firstAppearance: nil, image: "Twi'lek")
}
