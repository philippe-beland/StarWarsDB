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
class Character: Entity {
    var aliases: [StringName]
    var species: Species?
    var homeworld: Planet?
    var sex: Sex
    var affiliations: [Organization]
    var firstAppearance: String?
    
    var alias: String {
        var _alias: [String] = []
        for alias in aliases{
            _alias.append(alias.name)
        }
         
        return _alias.joined(separator: ", ")
    }
    
    var affiliation: String {
        var organizations: [String] = []
        for org in affiliations{
            organizations.append(org.name)
        }
         
        return organizations.joined(separator: ", ")
    }
    
    init(name: String, aliases: [StringName], species: Species?, homeworld: Planet?, sex: Sex, affiliations: [Organization], image: String?, comments: String = "", firstAppearance: String?) {
        self.aliases = aliases
        self.species = species
        self.homeworld = homeworld
        self.sex = sex
        self.affiliations = affiliations
        self.firstAppearance = firstAppearance
        
        super.init(name: name, comments: comments, image: image, recordType: "Character", tableName: "characters")
    }
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Character(name: "Luke Skywalker", aliases: [StringName("Red 5"), StringName("Red 4"), StringName("Red 3"), StringName("Red 2")], species: .example, homeworld: .example, sex: .Male, affiliations: [Organization.example], image: "Luke_Skywalker",  firstAppearance: nil)
    
    static let examples = [
        Character(name: "Luke Skywalker", aliases: [StringName("Red 5"), StringName("Red 4"), StringName("Red 3"), StringName("Red 2")], species: .example, homeworld: .example, sex: .Male, affiliations: [Organization.example], image: "Luke_Skywalker",  firstAppearance: nil),
        Character(name: "Luke Skywalker", aliases: [StringName("Red 5"), StringName("Red 4"), StringName("Red 3"), StringName("Red 2")], species: .example, homeworld: .example, sex: .Male, affiliations: [Organization.example], image: "Luke_Skywalker",  firstAppearance: nil)]
}
