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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case model
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, model: StarshipModel?, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()

        self.model = model
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Starship", tableName: "starships")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.model = try container.decodeIfPresent(StarshipModel.self, forKey: .model)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Starship", tableName: "starships")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if model != nil && model != .example {
            try container.encode(model?.id, forKey: .model)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Starship(name: "Millenium Falcon", model: .example, firstAppearance: nil, comments: "The best squadron ever")
    
    static let empty = Starship(name: "", model: nil, firstAppearance: nil, comments: "")
}
