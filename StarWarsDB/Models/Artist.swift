//
//  Artist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Artist: Entity {
    
    init(name: String, comments: String = "") {
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
        let comments = try container.decode(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Artist", tableName: "artists")
    }
    
    static let example = Artist(name: "Charles Soule")
}
