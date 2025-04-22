//
//  SourceOrganization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks organization appearances in Star Wars media sources
///
/// SourceOrganization specializes SourceItem for tracking how and where organizations
/// appear in different sources. This covers all types of groups, including:
/// - Political entities (Galactic Senate, First Order)
/// - Military forces (Rebel Alliance, Imperial Navy)
/// - Criminal syndicates (Hutt Cartel, Black Sun)
/// - Religious orders (Jedi Order, Sith)
/// - Commercial enterprises (Trade Federation)
@Observable
class SourceOrganization: SourceItem {
    
    /// Keys used for encoding and decoding source organization data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Organization being referenced
        case entity
        /// Type of appearance
        case appearance
        /// Number of appearances
        case number = "nb_appearances"
    }
    
    /// Creates a new source-organization relationship
    /// - Parameters:
    ///   - source: The source material where the organization appears
    ///   - entity: The organization that appears
    ///   - appearance: How the organization appears (present, mentioned, etc.)
    init(source: Source, entity: Organization, appearance: AppearanceType, number: Int = 0) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceOrganizations", tableName: "source_organizations")
    }
    
    /// Creates a source-organization relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Organization.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        let number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceOrganizations", tableName: "source_organizations")
    }
    
    /// Encodes the source-organization relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-organization relationships for previews and testing
    ///
    /// Shows how organizations might be referenced in sources. Organizations are
    /// often mentioned in dialogue or historical context, providing background
    /// for the political and social landscape of the Star Wars galaxy.
    static let example = [
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
    ]
}
