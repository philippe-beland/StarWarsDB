//
//  SourcePlanet.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks planet appearances in Star Wars media sources
///
/// SourcePlanet specializes SourceItem for tracking how and where planets appear
/// in different sources. This covers worlds across the galaxy, from the Core Worlds
/// to the Outer Rim. Planets can appear in various ways:
/// - As primary settings for the action
/// - In space travel sequences
/// - Through mentions in dialogue about trade routes or political affiliations
/// - In strategic discussions about military operations
@Observable
class SourcePlanet: SourceItem {
    
    /// Keys used for encoding and decoding source planet data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Planet being referenced (named "planet" in JSON)
        case entity = "planet"
        /// Type of appearance
        case appearance
        /// Number of appearances
        case number = "total_appearances"
    }
    
    /// Creates a new source-planet relationship
    /// - Parameters:
    ///   - source: The source material where the planet appears
    ///   - entity: The planet that appears
    ///   - appearance: How the planet appears (present, mentioned, etc.)
    init(source: Source, entity: Planet, appearance: AppearanceType, number: Int = 0) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourcePlanets", tableName: "source_planets")
    }
    
    /// Creates a source-planet relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Planet.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        //let number = try container.decode(Int.self, forKey: .number)
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourcePlanets", tableName: "source_planets")
    }
    
    /// Encodes the source-planet relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-planet relationships for previews and testing
    ///
    /// Shows how planets might be referenced in sources. Planets are frequently
    /// mentioned in Star Wars media, whether as story settings, destinations,
    /// or in discussions of galactic politics and trade. Many planets are
    /// referenced through dialogue or historical context rather than being
    /// directly shown.
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
