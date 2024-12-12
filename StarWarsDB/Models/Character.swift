//
//  Character.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Character: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var aliases: String
    var species: Species?
    var homeworld: Planet?
    var sex: String
    var affiliation: [Organisation]
    var comments: String?
    var firstAppearance: String?
    var url: String
    
    init(id: String, name: String, alias: String, species: Species?, homeworld: Planet?, sex: String, affiliation: [Organisation], comments: String?, firstAppearance: String?, url: String) {
        self.ID = id
        self.name = name
        self.aliases = alias
        self.species = species
        self.homeworld = homeworld
        self.sex = sex
        self.affiliation = affiliation
        self.comments = comments
        self.firstAppearance = firstAppearance
        self.url = url
    }
    
    static let example = Character(id: "1", name: "Luke Skywalker", alias: "Red 5", species: .example, homeworld: .example, sex: "male", affiliation: [], comments: nil, firstAppearance: nil, url: "")
}
