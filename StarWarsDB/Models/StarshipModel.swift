//
//  StarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

@Observable
class StarshipModel: Entity {
    var classType: String
    var line: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case classType = "class_type"
        case line
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
        
    }
    
    init(name: String, classType: String?, line: String?, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()
        
        self.classType = classType ?? ""
        self.line = line ?? ""
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Starship Model", tableName: "starship_models")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType) ?? ""
        self.line = try container.decodeIfPresent(String.self, forKey: .line) ?? ""
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Starship Model", tableName: "starship_models")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(classType, forKey: .classType)
        try container.encode(line, forKey: .line)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = StarshipModel(name: "YT-1300", classType: "Starfighter", line: nil, firstAppearance: nil, comments: "Best ship!")
    
    static let empty = StarshipModel(name: "", classType: nil, line: nil, firstAppearance: nil, comments: nil)
}
