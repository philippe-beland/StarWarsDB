//
//  SourceStarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

/// Tracks starship model appearances in Star Wars media sources
///
/// SourceStarshipModel specializes SourceItem for tracking how and where starship
/// designs and classes appear in different sources. Unlike SourceStarship which
/// tracks individual vessels, this tracks general ship types such as:
/// - Fighter classes (X-wing, TIE Fighter designs)
/// - Freighter models (YT series Corellian designs)
/// - Capital ship classes (Imperial Star Destroyer types)
/// - Transport designs (Lambda-class shuttles)
@Observable
class SourceStarshipModel: SourceItem {
    
    /// Keys used for encoding and decoding source starship model data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Starship model being referenced (named "starship_model" in JSON)
        case entity = "starship_model"
        /// Type of appearance
        case appearance
    }
    
    /// Creates a new source-starship model relationship
    /// - Parameters:
    ///   - source: The source material where the starship model appears
    ///   - entity: The starship model that appears
    ///   - appearance: How the model appears (present, mentioned, etc.)
    init(source: Source, entity: StarshipModel, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceStarshipModels", tableName: "source_starship_models")
    }
    
    /// Creates a source-starship model relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(StarshipModel.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceStarshipModels", tableName: "source_starship_models")
    }
    
    /// Encodes the source-starship model relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    /// Example source-starship model relationships for previews and testing
    ///
    /// Shows how starship models might be referenced in sources. Ship designs
    /// are often mentioned in technical discussions, fleet descriptions, or
    /// when introducing new vessels to the Star Wars universe.
    static let example = [
        SourceStarshipModel(source: .example, entity: .example, appearance: .mentioned)
    ]
}
