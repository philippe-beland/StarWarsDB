//
//  SourceVaria.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceVaria: SourceItem {
    
    init(source: Source, entity: Varia, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceVarias", tableName: "source_varias")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
    ]
}
