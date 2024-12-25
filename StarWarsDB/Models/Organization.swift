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
    
    static let example = Organization(name: "Alphabet Squadron", firstAppearance: nil, comments: "The best squadron ever")
}
