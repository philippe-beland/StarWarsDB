//
//  Arc.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Arc: Entity {
    var serie: Serie
    
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
        
        self.serie = try container.decode(Serie.self, forKey: .serie)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Arc", tableName: "arcs")
    }
    
    static let example = Arc(name: "Battle for the Force", serie: .example, comments: nil)
}
