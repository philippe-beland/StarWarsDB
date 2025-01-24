//
//  Species.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents a sentient species in the Star Wars universe
///
/// Species are the various sentient races that inhabit the galaxy. Each species has
/// its own unique characteristics, culture, and often a homeworld where they originated.
/// Species can range from the numerous humans to exotic aliens like the Twi'leks or Wookiees.
@Observable
class Species: Entity {
    /// The planet where this species originated
    ///
    /// Many species have a specific planet of origin that shaped their evolution
    /// and cultural development. Some species may have lost their homeworld or
    /// spread widely across the galaxy.
    var homeworld: Planet?
    
    /// Keys used for encoding and decoding species data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Species name
        case name
        /// Planet of origin
        case homeworld
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a new species
    /// - Parameters:
    ///   - name: The name of the species
    ///   - homeworld: The species' planet of origin
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the species
    init(name: String, homeworld: Planet?, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()
        self.homeworld = homeworld
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Species", tableName: "species")
    }
    
    /// Creates a species from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Species", tableName: "species")
    }
    
    /// Encodes the species into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if homeworld != nil && homeworld != .example {
            try container.encode(homeworld?.id, forKey: .homeworld)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example species for previews and testing
    ///
    /// Twi'leks are a sentient species from the planet Ryloth, known for their
    /// distinctive head-tails (lekku) and their presence throughout the galaxy
    /// in various roles from politicians to dancers.
    static let example = Species(
        name: "Twi'lek",
        homeworld: .example,
        firstAppearance: nil
    )
    
    /// An empty species for initialization
    static let empty = Species(
        name: "",
        homeworld: .empty,
        firstAppearance: nil
    )
}
