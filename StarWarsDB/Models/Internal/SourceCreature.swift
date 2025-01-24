//
//  SourceCreature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks creature appearances in Star Wars media sources
///
/// SourceCreature specializes SourceItem for tracking how and where non-humanoid
/// creatures appear in different sources. This includes both sentient and
/// non-sentient creatures, from Rancors to Tauntauns, whether they play major
/// roles or are simply part of the background fauna.
@Observable
class SourceCreature: SourceItem {
    
    /// Keys used for encoding and decoding source creature data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Creature being referenced (named "creature" in JSON)
        case entity = "creature"
        /// Type of appearance
        case appearance
    }
    
    /// Creates a new source-creature relationship
    /// - Parameters:
    ///   - source: The source material where the creature appears
    ///   - entity: The creature that appears
    ///   - appearance: How the creature appears (present, mentioned, etc.)
    init(source: Source, entity: Creature, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceCreatures", tableName: "source_creatures")
    }
    
    /// Creates a source-creature relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Creature.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceCreatures", tableName: "source_creatures")
    }
    
    /// Encodes the source-creature relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-creature relationships for previews and testing
    ///
    /// Shows how creatures might be referenced in sources, typically through
    /// mentions rather than direct appearances, as many creatures serve as
    /// background elements or are referenced in dialogue about a planet's fauna.
    static let example = [
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
        SourceCreature(source: .example, entity: .example, appearance: .mentioned),
    ]
}
