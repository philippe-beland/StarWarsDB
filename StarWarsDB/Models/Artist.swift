//
//  Artist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Artist: Entity {
    
    init(name: String, comments: String? = nil) {
        let id = UUID()
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Artist", tableName: "artists")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case comments
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Artist", tableName: "artists")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Artist(name: "Charles Soule")
    static let empty = Artist(name: "")
}
