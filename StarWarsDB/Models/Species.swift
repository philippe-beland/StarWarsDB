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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case homeworld
        case firstAppearance = "first_appearance"
        case comments
    }
    
    init(name: String, homeworld: Planet?, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()
        self.homeworld = homeworld
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Species", tableName: "species")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Species", tableName: "species")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if homeworld != nil && homeworld != .example {
            try container.encode(homeworld?.id, forKey: .homeworld)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Species(name: "Twi'lek", homeworld: .example, firstAppearance: nil)
    static let empty = Species(name: "", homeworld: .empty, firstAppearance: nil)
}
