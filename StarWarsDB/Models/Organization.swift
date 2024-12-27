//
//  Organization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Organization: Entity {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstAppearance = "first_appearance"
        case comments
    }
    
    init(name: String, firstAppearance: String?, comments: String?) {
        let id = UUID()
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Organization", tableName: "organizations")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Organization", tableName: "organizations")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(self.firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Organization(name: "Alphabet Squadron", firstAppearance: nil, comments: "The best squadron ever")
    
    static let empty = Organization(name: "", firstAppearance: nil, comments: nil)
}
