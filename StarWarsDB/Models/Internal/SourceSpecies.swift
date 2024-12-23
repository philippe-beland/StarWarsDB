//
//  SourceSpecies.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceSpecies: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity
        case appearance
    }
    
    init(source: Source, entity: Species, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceSpecies", tableName: "source_species")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        let appearance = try container.decode(AppearanceType.self, forKey: .appearance)
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceSpecies", tableName: "source_species")
    }
    
    static let example = [
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned)
    ]
}
