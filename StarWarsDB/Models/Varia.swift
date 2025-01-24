//
//  Varia.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents miscellaneous items and concepts in the Star Wars universe
///
/// Varia encompasses elements that don't fit into other specific categories,
/// such as games (like Sabacc), technologies, cultural practices, or other
/// notable aspects of the Star Wars universe that aren't characters,
/// vehicles, or locations.
@Observable
class Varia: Entity {
    
    /// Keys used for encoding and decoding varia data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Item or concept name
        case name
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a new varia item
    /// - Parameters:
    ///   - name: The name of the item or concept
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the item
    init(name: String, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()

        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Varia", tableName: "varias")
    }
    
    /// Creates a varia item from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Varia", tableName: "varias")
    }
    
    /// Encodes the varia item into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example varia item for previews and testing
    static let example = Varia(
        name: "Sabacc",
        firstAppearance: nil,
        comments: "Card Game"
    )
    
    /// An empty varia item for initialization
    static let empty = Varia(
        name: "",
        firstAppearance: nil,
        comments: nil
    )
}
