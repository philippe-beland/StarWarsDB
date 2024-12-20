//
//  SourceCreature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceCreature: SourceItem {
    
    init(source: Source, entity: Creature, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceCreatures", tableName: "source_creatures")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
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
