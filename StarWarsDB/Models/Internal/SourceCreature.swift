//
//  SourceCreature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceCreature: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var entity: Creature
    var appearance: AppearanceType
    
    init(source: Source, entity: Creature, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.entity = entity
        self.appearance = appearance
        
        super.init(recordType: "SourceCreatures", tableName: "source_creatures", recordID: self.id)
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
    
    static func == (lhs: SourceCreature, rhs: SourceCreature) -> Bool {
        lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
