//
//  SourcePlanet.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourcePlanet: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var entity: Planet
    var appearance: AppearanceType
    
    init(source: Source, entity: Planet, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.entity = entity
        self.appearance = appearance
        
        super.init(recordType: "SourcePlanets", tableName: "source_planets", recordID: self.id)
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
    
    static func == (lhs: SourcePlanet, rhs: SourcePlanet) -> Bool {
        lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
