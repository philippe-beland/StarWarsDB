//
//  Droid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Droid: Entity {
    var classType: String?
    
    init(name: String, classType: String?, firstAppearance: String?, comments: String?) {
        let id = UUID()
        self.classType = classType
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Droid", tableName: "droids")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case classType = "class_type"
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Droid", tableName: "droids")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(classType, forKey: .classType)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Droid(name: "R2 astromech droid", classType: "Astromech droid", firstAppearance: nil, comments: "Astromech droid with a high degree of mechanical aptitude.")
    
    static let empty = Droid(name: "", classType: nil, firstAppearance: nil, comments: nil)
}
