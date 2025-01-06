//
//  Varia.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Varia: Entity {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()

        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Varia", tableName: "varias")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Varia", tableName: "varias")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Varia(name: "Sabacc", firstAppearance: nil, comments: "Card Game")
    static let empty = Varia(name: "", firstAppearance: nil, comments: nil)
}
