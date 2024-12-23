//
//  SourceCharacter.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceCharacter: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity
        case appearance
    }
    
    init(source: Source, entity: Character, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceCharacters", tableName: "source_characters")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        let appearance = try container.decode(AppearanceType.self, forKey: .appearance)
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceCharacters", tableName: "source_characters")
    }
    
    static let example = [
        SourceCharacter(source: .example, entity: .example, appearance: .present),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .image),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .flashback),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .vision),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
    ]
}
