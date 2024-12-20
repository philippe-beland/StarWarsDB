//
//  SourcePlanet.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourcePlanet: SourceItem {
    
    init(source: Source, entity: Planet, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourcePlanets", tableName: "source_planets")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourcePlanet(source: .example, entity: .example, appearance: .mentioned),
        SourcePlanet(source: .example, entity: .example, appearance: .mentioned),
        SourcePlanet(source: .example, entity: .example, appearance: .mentioned),
        SourcePlanet(source: .example, entity: .example, appearance: .mentioned),
        SourcePlanet(source: .example, entity: .example, appearance: .mentioned),
        SourcePlanet(source: .example, entity: .example, appearance: .mentioned),
        SourcePlanet(source: .example, entity: .example, appearance: .mentioned),
    ]
}
