//
//  SourceVaria.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks miscellaneous item appearances in Star Wars media sources
///
/// SourceVaria specializes SourceItem for tracking how and where various items
/// and concepts appear that don't fit into other categories. This includes:
/// - Games and entertainment (Sabacc, Dejarik)
/// - Cultural elements (festivals, traditions)
/// - Technologies (holocrons, hyperdrives)
/// - Artifacts (lightsaber crystals, ancient relics)
/// - Concepts (the Force, hyperspace lanes)
@Observable
class SourceVaria: SourceItem {
    
    /// Keys used for encoding and decoding source varia data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Varia item being referenced (named "varia" in JSON)
        case entity = "varia"
        /// Type of appearance
        case appearance
        /// Number of appearances
        case number = "total_appearances"
    }
    
    /// Creates a new source-varia relationship
    /// - Parameters:
    ///   - source: The source material where the item appears
    ///   - entity: The item that appears
    ///   - appearance: How the item appears (present, mentioned, etc.)
    init(source: Source, entity: Varia, appearance: AppearanceType, number: Int = 0) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceVarias", tableName: "source_varias")
    }
    
    /// Creates a source-varia relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Varia.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        //let number = try container.decode(Int.self, forKey: .number)
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceVarias", tableName: "source_varias")
    }
    
    /// Encodes the source-varia relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-varia relationships for previews and testing
    ///
    /// Shows how miscellaneous items might be referenced in sources. These can
    /// range from casual mentions of games or cultural practices to detailed
    /// explanations of important technologies or mystical concepts in the
    /// Star Wars universe.
    static let example = [
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
    ]
}
