//
//  SourceStarship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceStarship: SourceItem {
    
    init(source: Source, entity: Starship, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceStarships", tableName: "source_starships")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
    ]
}
