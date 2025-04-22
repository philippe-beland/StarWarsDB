//
//  Organization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents an organization in the Star Wars universe
///
/// Organizations can be various types of groups including:
/// - Military forces (e.g., Rebel Alliance, Imperial Navy)
/// - Political entities (e.g., Galactic Senate, First Order)
/// - Criminal syndicates (e.g., Hutt Cartel, Black Sun)
/// - Commercial enterprises (e.g., Trade Federation)
/// - Religious orders (e.g., Jedi Order, Sith)
@Observable
class Organization: Entity {
    
    /// Keys used for encoding and decoding organization data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Organization's name
        case name
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a new organization
    /// - Parameters:
    ///   - name: The organization's name
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the organization
    init(name: String, firstAppearance: String?, comments: String?) {
        let id: UUID = UUID()
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Organization", tableName: "organizations")
    }
    
    /// Creates an organization from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Organization.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Organization", tableName: "organizations")
    }
    
    /// Encodes the organization into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Organization.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(self.firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example organization for previews and testing
    static let example: Organization = Organization(
        name: "Alphabet Squadron",
        firstAppearance: nil,
        comments: "The best squadron ever"
    )
    
    /// An empty organization for initialization
    static let empty: Organization = Organization(
        name: "",
        firstAppearance: nil,
        comments: nil
    )
}
