//
//  SourceCreature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceCreature: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity
        case appearance
    }
    
    init(source: Source, entity: Creature, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceCreatures", tableName: "source_creatures")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        let appearance = try container.decode(AppearanceType.self, forKey: .appearance)
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceCreatures", tableName: "source_creatures")
    }
    
    static let example = [
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
    ]
}
