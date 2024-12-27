//
//  Serie.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Serie: Entity {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case comments
    }
    
    init(name: String, comments: String?) {
        let id = UUID()
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Serie", tableName: "series")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Serie", tableName: "series")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Serie(name: "Rebels", comments: "Series about the adventures of Ghost Squadron")
    
    static let empty = Serie(name: "", comments: nil)
}
