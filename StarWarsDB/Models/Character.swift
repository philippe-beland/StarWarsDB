//
//  Character.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

enum Sex: String, Codable {
    case Male
    case Female
    case Other
}

@Observable
class Character: DataNode, Record {
    let id: UUID
    var name: String
    var aliases: [StringName]
    var species: Species?
    var homeworld: Planet?
    var sex: Sex
    var affiliation: [Organization]
    var comments: String?
    var firstAppearance: String?
    var url: String
    
    init(name: String, aliases: [StringName], species: Species?, homeworld: Planet?, sex: Sex, affiliation: [Organization], comments: String?, firstAppearance: String?, url: String) {
        self.id = UUID()
        self.name = name
        self.aliases = aliases
        self.species = species
        self.homeworld = homeworld
        self.sex = sex
        self.affiliation = affiliation
        self.comments = comments
        self.firstAppearance = firstAppearance
        self.url = url
        
        super.init(recordType: "Character", tableName: "characters", recordID: self.id)
    }
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Character(name: "Luke Skywalker", aliases: [StringName("Red 5"), StringName("Red 4"), StringName("Red 3"), StringName("Red 2")], species: .example, homeworld: .example, sex: .Male, affiliation: [Organization.example], comments: nil, firstAppearance: nil, url: "")
}
