import Foundation

/// Represents the galactic regions in the Star Wars universe
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

/// Represents a planet or space station in the Star Wars universe
@Observable
class Planet: Entity {
    var region: Region
    var sector: String
    var system: String
    var capitalCity: String
    
    /// Notable locations or points of interest on the planet
    var destinations: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case region
        case sector
        case system
        case capitalCity = "capital_city"
        case destinations
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, region: Region? = nil, sector: String? = nil, system: String? = nil, capitalCity: String? = nil, destinations: [String], firstAppearance: String? = nil, comments: String? = nil) {
        let id: UUID = UUID()
        self.region = region ?? .unknown
        self.sector = sector ?? ""
        self.system = system ?? ""
        self.capitalCity = capitalCity ?? ""
        self.destinations = destinations
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Planet", databaseTableName: "planets")
    }
    
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
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Planet", databaseTableName: "planets")
    }
    
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
