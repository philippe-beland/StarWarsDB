//
//  SourceDroid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceDroid: SourceItem {
    
    init(source: Source, entity: Droid, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceDroids", tableName: "source_droids")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
    ]
}
