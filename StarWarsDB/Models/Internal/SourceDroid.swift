//
//  SourceDroid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceDroid: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity = "droid"
        case appearance
    }
    
    init(source: Source, entity: Droid, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceDroids", tableName: "source_droids")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Droid.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceDroids", tableName: "source_droids")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    static let example = [
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
    ]
}
