//
//  SourceDroid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks droid appearances in Star Wars media sources
///
/// SourceDroid specializes SourceItem for tracking how and where droids appear
/// in different sources. This covers all types of artificial beings, from
/// protocol droids like C-3PO to astromechs like R2-D2, whether they are
/// main characters or background elements.
@Observable
class SourceDroid: SourceItem {
    
    /// Keys used for encoding and decoding source droid data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Droid being referenced (named "droid" in JSON)
        case entity = "droid"
        /// Type of appearance
        case appearance
    }
    
    /// Creates a new source-droid relationship
    /// - Parameters:
    ///   - source: The source material where the droid appears
    ///   - entity: The droid that appears
    ///   - appearance: How the droid appears (present, mentioned, etc.)
    init(source: Source, entity: Droid, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceDroids", tableName: "source_droids")
    }
    
    /// Creates a source-droid relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Droid.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceDroids", tableName: "source_droids")
    }
    
    /// Encodes the source-droid relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-droid relationships for previews and testing
    ///
    /// Shows how droids might be referenced in sources. While some droids like
    /// R2-D2 and C-3PO are main characters with physical appearances, many
    /// others are mentioned in passing or appear as background elements.
    static let example = [
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
    ]
}
