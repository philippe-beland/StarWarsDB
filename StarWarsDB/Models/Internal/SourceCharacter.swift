//
//  SourceCharacter.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceCharacter: SourceItem {
    
    init(source: Source, entity: Character, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceCharacters", tableName: "source_characters")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
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
