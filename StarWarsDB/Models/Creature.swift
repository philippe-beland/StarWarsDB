//
//  Creature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents a creature in the Star Wars universe
///
/// Creatures are non-humanoid life forms that can be either sentient or non-sentient.
/// They can be native to specific planets and play various roles in the Star Wars ecosystem,
/// from pets to dangerous predators.
@Observable
class Creature: Entity {
    /// The creature's sentience designation (e.g., "Sentient", "Non-sentient")
    var designation: String?
    
    /// The creature's home planet
    var homeworld: Planet?
    
    /// Creates a new creature
    /// - Parameters:
    ///   - name: The creature's name or species
    ///   - designation: The creature's sentience level
    ///   - homeworld: The planet where the creature originates
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the creature
    init(name: String, designation: String?, homeworld: Planet?, firstAppearance: String?, comments: String?) {
        let id: UUID = UUID()
        self.designation = designation
        self.homeworld = homeworld
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Creature", tableName: "creatures")
    }
    
    /// Keys used for encoding and decoding creature data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Creature's name
        case name
        /// Sentience designation
        case designation
        /// Home planet
        case homeworld
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a creature from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Creature.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.designation = try container.decodeIfPresent(String.self, forKey: .designation)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Creature", tableName: "creatures")
    }
    
    /// Encodes the creature into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Creature.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(designation, forKey: .designation)
        if homeworld != nil && homeworld != .example {
            try container.encode(homeworld?.id, forKey: .homeworld)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example creature for previews and testing
    static let example = Creature(name: "Dianoga", designation: "Non-sentient", homeworld: .example, firstAppearance: nil, comments: nil)
    
    /// An empty creature for initialization
    static let empty = Creature(name: "", designation: "", homeworld: nil, firstAppearance: nil, comments: nil)
}
