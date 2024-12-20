//
//  Starship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Starship: Entity {
    var model: StarshipModel?
    var firstAppearance: String?
    
    init(name: String, model: StarshipModel?, firstAppearance: String?, image: String?, comments: String = "") {
        self.firstAppearance = firstAppearance
        self.model = model
        
        super.init(name: name, comments: comments, image: image, recordType: "Starship", tableName: "starships")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Starship(name: "Millenium Falcon", model: .example, firstAppearance: nil, image: "Millenium_Falcon", comments: "The best squadron ever")
}
