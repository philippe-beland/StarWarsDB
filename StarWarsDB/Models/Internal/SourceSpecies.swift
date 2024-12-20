//
//  SourceSpecies.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceSpecies: SourceItem {
    
    init(source: Source, entity: Species, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceSpecies", tableName: "source_species")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned)
    ]
}
