//
//  Planet.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents the galactic regions in the Star Wars universe
///
/// The galaxy is divided into several distinct regions, each with its own characteristics
/// and level of development. These regions are organized in a roughly concentric pattern,
/// from the Deep Core to the Outer Rim.
enum Region: String, Codable, CaseIterable {
    /// The innermost region of the galaxy, densely packed with stars
    case deepCore = "Deep Core"
    /// The most heavily settled and developed region
    case core = "Core Worlds"
    /// The first area of major expansion beyond the Core
    case colonies = "Colonies"
    /// A heavily populated region between the Colonies and Expansion Region
    case innerRim = "Inner Rim Territories"
    /// A region of early colonization efforts
    case expansion = "Expansion Region"
    /// A region of sparse settlement between the Inner and Outer Rim
    case midRim = "Mid Rim Territories"
    /// A frontier region in the galactic west
    case westernReaches = "Western Reaches"
    /// The sparsely inhabited frontier of the galaxy
    case outerRim = "Outer Rim Territories"
    /// Unexplored space beyond the galactic frontier
    case unknownRegion = "Unknown Regions"
    /// Largely unexplored space along the galaxy's edge
    case wildSpace = "Wild Space"
    /// Space outside the main galaxy
    case extraGalactic = "Extragalactic"
    /// Region is not known or recorded
    case unknown = "Unknown"
}

/// Represents a planet in the Star Wars universe
///
/// Planets are celestial bodies that can range from populated worlds at the heart of
/// galactic civilization to remote, uninhabited worlds on the Outer Rim. Each planet
/// has its own characteristics, political affiliations, and historical significance.
@Observable
class Planet: Entity {
    /// The galactic region where the planet is located
    var region: Region
    
    /// The sector of space containing the planet
    var sector: String
    
    /// The star system the planet belongs to
    var system: String
    
    /// The planet's primary city or administrative center
    var capitalCity: String
    
    /// Notable locations or points of interest on the planet
    var destinations: [String]
    
    /// Keys used for encoding and decoding planet data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Planet's name
        case name
        /// Galactic region
        case region
        /// Sector location
        case sector
        /// Star system
        case system
        /// Primary city
        case capitalCity = "capital_city"
        /// Notable locations
        case destinations
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a new planet
    /// - Parameters:
    ///   - name: The planet's name
    ///   - region: The galactic region where the planet is located
    ///   - sector: The sector of space containing the planet
    ///   - system: The star system the planet belongs to
    ///   - capitalCity: The planet's primary city
    ///   - destinations: Notable locations on the planet
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the planet
    init(name: String, region: Region? = nil, sector: String? = nil, system: String? = nil, capitalCity: String? = nil, destinations: [String], firstAppearance: String? = nil, comments: String? = nil) {
        let id: UUID = UUID()
        self.region = region ?? .unknown
        self.sector = sector ?? ""
        self.system = system ?? ""
        self.capitalCity = capitalCity ?? ""
        self.destinations = destinations
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Planet", tableName: "planets")
    }
    
    /// Creates a planet from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Planet.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.region = try container.decodeIfPresent(Region.self, forKey: .region) ?? .unknown
        self.sector = try container.decodeIfPresent(String.self, forKey: .sector) ?? ""
        self.system = try container.decodeIfPresent(String.self, forKey: .system) ?? ""
        self.capitalCity = try container.decodeIfPresent(String.self, forKey: .capitalCity) ?? ""
        self.destinations = try container.decode([String].self, forKey: .destinations)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Planet", tableName: "planets")
    }
    
    /// Encodes the planet into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Planet.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(region, forKey: .region)
        if sector != "" {
            try container.encode(sector, forKey: .sector)
        }
        if system != "" {
            try container.encode(system, forKey: .system)
        }
        if capitalCity != "" {
            try container.encode(capitalCity, forKey: .capitalCity)
        }
        try container.encode(destinations, forKey: .destinations)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example planet for previews and testing
    static let example: Planet = Planet(
        name: "Tatooine",
        region: .outerRim,
        sector: "Arkanis",
        system: "Tatoo",
        capitalCity: "Mos Eisley",
        destinations: ["Anchorhead", "Bestine", "Freetown", "Mos Espa"],
        firstAppearance: "A New Hope",
        comments: "Tatooine was a sparsely inhabited circumbinary desert planet located in the galaxy's Outer Rim Territories. Part of a binary star system, the planet orbited two scorching suns, resulting in the world lacking the necessary surface water to sustain large populations. As a result, many residents of the planet instead drew water from the atmosphere via moisture farms. The planet also had little surface vegetation. It was the homeworld to the native Jawa and Tusken Raider species and of Anakin and Luke Skywalker, who would go on to shape galactic history."
    )
    
    /// An empty planet for initialization
    static let empty: Planet = Planet(
        name: "",
        region: .outerRim,
        sector: "",
        system: "",
        capitalCity: "",
        destinations: [],
        firstAppearance: "",
        comments: ""
    )
}
