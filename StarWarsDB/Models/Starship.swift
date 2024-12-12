//
//  Starship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Starship: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var model: StarshipModel?
    var comments: String?
    
    init(id: String, name: String, model: StarshipModel?, comments: String?) {
        self.ID = id
        self.name = name
        self.model = model
        self.comments = comments
    }
    
    static let example = Starship(id: "1", name: "Millenium Falcon", model: .example, comments: "The best squadron ever")
}
