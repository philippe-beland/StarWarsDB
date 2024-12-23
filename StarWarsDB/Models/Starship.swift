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
    }
    
    init(name: String, model: StarshipModel?, firstAppearance: String?, comments: String = "") {
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
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Starship", tableName: "starships")
    }
    
    static let example = Starship(name: "Millenium Falcon", model: .example, firstAppearance: nil, comments: "The best squadron ever")
}
