//
//  Planet.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

enum Region: String, Codable, CaseIterable {
    case deepCore = "Deep Core"
    case core = "Core Worlds"
    case colonies = "Colonies"
    case innerRim = "Inner Rim Territories"
    case expansion = "Expansion Region"
    case midRim = "Mid Rim Territories"
    case westernReaches = "Western Reaches"
    case outerRim = "Outer Rim Territories"
    case unknownRegion = "Unknown Regions"
    case wildSpace = "Wild Space"
    case extraGalactic = "Extragalactic"
    case unknown = "Unknown"
    
}

@Observable
class Planet: Entity {
    var region: Region
    var sector: String
    var system: String
    var capitalCity: String
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
    }
    
    init(name: String, region: Region? = nil, sector: String? = nil, system: String? = nil, capitalCity: String? = nil, destinations: [String], firstAppearance: String? = nil, comments: String? = nil) {
        
        let id = UUID()
        self.region = region ?? .unknown
        self.sector = sector ?? ""
        self.system = system ?? ""
        self.capitalCity = capitalCity ?? ""
        self.destinations = destinations
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Planet", tableName: "planets")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.region = try container.decodeIfPresent(Region.self, forKey: .region) ?? .unknown
        self.sector = try container.decodeIfPresent(String.self, forKey: .sector) ?? ""
        self.system = try container.decodeIfPresent(String.self, forKey: .system) ?? ""
        self.capitalCity = try container.decodeIfPresent(String.self, forKey: .capitalCity) ?? ""
        self.destinations = try container.decode([String].self, forKey: .destinations)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Planet", tableName: "planets")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
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
    
    static let example = Planet(name: "Tatooine", region: .outerRim, sector: "Arkanis", system: "Tatoo", capitalCity: "Mos Eisley", destinations: ["Anchorhead", "Bestine", "Freetown", "Mos Espa"], firstAppearance: "A New Hope", comments: "Tatooine was a sparsely inhabited circumbinary desert planet located in the galaxy's Outer Rim Territories. Part of a binary star system, the planet orbited two scorching suns, resulting in the world lacking the necessary surface water to sustain large populations. As a result, many residents of the planet instead drew water from the atmosphere via moisture farms. The planet also had little surface vegetation. It was the homeworld to the native Jawa and Tusken Raider species and of Anakin and Luke Skywalker, who would go on to shape galactic history.")
    
    static let empty = Planet(name: "", region: .outerRim, sector: "", system: "", capitalCity: "", destinations: [], firstAppearance: "", comments: "")
}
