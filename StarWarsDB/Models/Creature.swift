//
//  Creature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Creature: Entity {
    var designation: String?
    var homeworld: Planet?
    
    init(name: String, designation: String?, homeworld: Planet?, firstAppearance: String?, comments: String?) {
        let id = UUID()
        self.designation = designation
        self.homeworld = homeworld
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Creature", tableName: "creatures")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case designation
        case homeworld
        case firstAppearance = "first_appearance"
        case comments
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.designation = try container.decodeIfPresent(String.self, forKey: .designation)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Creature", tableName: "creatures")
    }
    
    static let example = Creature(name: "Dianoga", designation: "Non-sentient", homeworld: .example, firstAppearance: nil, comments: nil)
}
