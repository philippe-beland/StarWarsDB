//
//  SourceCharacter.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks character appearances in Star Wars media sources
///
/// SourceCharacter specializes SourceItem for tracking how and where characters
/// appear in different sources. This allows tracking a character's presence across
/// the Star Wars universe, whether they are physically present, mentioned in dialogue,
/// seen in flashbacks, etc.
@Observable
class SourceCharacter: SourceItem {
    
    /// Keys used for encoding and decoding source character data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Character being referenced (named "character" in JSON)
        case entity
        /// Type of appearance
        case appearance
        /// Number of appearances
        case number = "nb_appearances"
    }
    
    /// Creates a new source-character relationship
    /// - Parameters:
    ///   - source: The source material where the character appears
    ///   - entity: The character that appears
    ///   - appearance: How the character appears (present, mentioned, etc.)
    init(source: Source, entity: Character, appearance: AppearanceType, number: Int = 0) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceCharacters", tableName: "source_characters")
    }
    
    /// Creates a source-character relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Character.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        let number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceCharacters", tableName: "source_characters")
    }
    
    /// Encodes the source-character relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-character relationships for previews and testing
    ///
    /// Demonstrates various ways a character might appear in sources:
    /// - Physical presence in scenes
    /// - Verbal mentions by other characters
    /// - Appearances in flashbacks
    /// - Visions through the Force
    /// - Images or holograms
    static let example = [
        SourceCharacter(source: .example, entity: .example, appearance: .present),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .image),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .flashback),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .vision),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
        SourceCharacter(source: .example, entity: .example, appearance: .mentioned),
    ]
}
