//
//  SourceStarship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks starship appearances in Star Wars media sources
///
/// SourceStarship specializes SourceItem for tracking how and where specific
/// starships appear in different sources. This covers individual vessels
/// rather than general ship classes, tracking famous ships like:
/// - Iconic vessels (Millennium Falcon, Death Star)
/// - Personal ships (Luke's X-wing, Slave I)
/// - Capital ships (Star Destroyers, Mon Calamari cruisers)
/// - Notable freighters and transports
@Observable
class SourceStarship: SourceItem {
    
    /// Keys used for encoding and decoding source starship data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Starship being referenced
        case entity
        /// Type of appearance
        case appearance
        /// Number of appearances
        case number = "nb_appearances"
    }
    
    /// Creates a new source-starship relationship
    /// - Parameters:
    ///   - source: The source material where the starship appears
    ///   - entity: The starship that appears
    ///   - appearance: How the starship appears (present, mentioned, etc.)
    init(source: Source, entity: Starship, appearance: AppearanceType, number: Int = 0) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceStarships", tableName: "source_starships")
    }
    
    /// Creates a source-starship relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Starship.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        let number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceStarships", tableName: "source_starships")
    }
    
    /// Encodes the source-starship relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-starship relationships for previews and testing
    ///
    /// Shows how starships might be referenced in sources. While some ships
    /// like the Millennium Falcon are central to the story, others might be
    /// mentioned in passing during fleet descriptions or space battles.
    static let example = [
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
    ]
}
