//
//  Arc.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Arc: Entity {
    var serie: Serie?
    
    init(name: String, serie: Serie, comments: String?) {
        let id = UUID()
        self.serie = serie
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Arc", tableName: "arcs")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case serie
        case comments
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.serie = try container.decodeIfPresent(Serie.self, forKey: .serie)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Arc", tableName: "arcs")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if serie != nil {
            try container.encode(serie?.id, forKey: .serie)
        }
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Arc(name: "Battle for the Force", serie: .example, comments: nil)
    
    static let empty = Arc(name: "", serie: .empty, comments: nil)
}
