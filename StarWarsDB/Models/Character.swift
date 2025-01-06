//
//  Character.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

enum Gender: String, Codable, CaseIterable {
    case Male
    case Female
    case Other
    case Unknown
}

@Observable
class Character: Entity {
    var aliases: [String]
    var species: Species?
    var homeworld: Planet?
    var gender: Gender
    //var affiliations: [Organization]
    
    var alias: String {
        aliases.joined(separator: ", ")
    }
    
//    var affiliation: String {
//        var organizations: [String] = []
//        for org in affiliations{
//            organizations.append(org.name)
//        }
//         
//        return organizations.joined(separator: ", ")
//    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case aliases
        case species
        case homeworld
        case gender
        //case affiliations
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, aliases: [String], species: Species?, homeworld: Planet?, gender: Gender?, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()
        self.aliases = aliases
        self.species = species
        self.homeworld = homeworld
        self.gender = gender ?? .Unknown
        //self.affiliations = affiliations
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Character", tableName: "characters")
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        if let aliases = try container.decodeIfPresent([String].self, forKey: .aliases) {
            self.aliases = aliases
        } else {
            self.aliases = []
        }
        
        self.species = try container.decodeIfPresent(Species.self, forKey: .species)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender) ?? .Unknown
//        if let affiliations = try container.decodeIfPresent([Organization].self, forKey: .affiliations) {
//            self.affiliations = affiliations
//        } else {
//            self.affiliations = []
//        }
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Character", tableName: "characters")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(aliases, forKey: .aliases)
        if species != nil && species != .example {
            try container.encode(species?.id, forKey: .species)
        }
        if homeworld != nil && homeworld != .example {
            try container.encode(homeworld?.id, forKey: .homeworld)
        }
        try container.encode(gender, forKey: .gender)
        //try container.encode(affiliations, forKey: .affiliations)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Character(name: "Luke Skywalker", aliases: ["Red 5", "Red 4", "Red 3", "Red 2"], species: .example, homeworld: .example, gender: .Male, firstAppearance: nil)
    
    static let examples = [
        Character(name: "Luke Skywalker", aliases: ["Red 5", "Red 4", "Red 3", "Red 2"], species: .example, homeworld: .example, gender: .Male, firstAppearance: nil),
        Character(name: "Luke Skywalker", aliases: ["Red 5", "Red 4", "Red 3", "Red 2"], species: .example, homeworld: .example, gender: .Male, firstAppearance: nil)]
    
    static let empty = Character(name: "", aliases: [], species: .empty, homeworld: .empty, gender: .Male, firstAppearance: nil)
}
