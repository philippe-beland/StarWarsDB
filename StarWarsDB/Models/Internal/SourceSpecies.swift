//
//  SourceSpecies.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks species appearances in Star Wars media sources
///
/// SourceSpecies specializes SourceItem for tracking how and where different
/// sentient species appear in sources. This covers the diverse races that
/// populate the galaxy, from the numerous humans to exotic aliens. Species
/// can be referenced in various contexts:
/// - As main characters or background populations
/// - In discussions of galactic politics and culture
/// - Through historical references about their homeworlds
/// - In relation to their technological achievements or traditions
@Observable
class SourceSpecies: SourceItem {
    
    /// Keys used for encoding and decoding source species data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Species being referenced (named "species" in JSON)
        case entity = "species"
        /// Type of appearance
        case appearance
        /// Number of appearances
        case number = "total_appearances"
    }
    
    /// Creates a new source-species relationship
    /// - Parameters:
    ///   - source: The source material where the species appears
    ///   - entity: The species that appears
    ///   - appearance: How the species appears (present, mentioned, etc.)
    init(source: Source, entity: Species, appearance: AppearanceType, number: Int = 0) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceSpecies", tableName: "source_species")
    }
    
    /// Creates a source-species relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Species.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        //let number = try container.decode(Int.self, forKey: .number)
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceSpecies", tableName: "source_species")
    }
    
    /// Encodes the source-species relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-species relationships for previews and testing
    ///
    /// Shows how species might be referenced in sources. While some species
    /// like humans are ubiquitous, others might only be mentioned in passing
    /// or appear in specific contexts related to their homeworlds or cultural
    /// significance in the galaxy.
    static let example = [
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned),
        SourceSpecies(source: .example, entity: .example, appearance: .mentioned)
    ]
}
