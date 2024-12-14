//
//  Planet.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

enum Region: String, Codable {
    case deepCore = "Deep Core"
    case core = "Core Worlds"
    case colonies = "Colonies"
    case innerRim = "Inner Rim"
    case expansion = "Expansion Region"
    case midRim = "Mid Rim"
    case outerRim = "Outer Rim"
    case unknown = "Unknown Regions"
    case wildSpace = "Wild Space"
}

@Observable
class Planet: DataNode, Record, Hashable {
    let id: UUID
    var name: String
    var region: Region?
    var sector: String?
    var system: String?
    var capital: String?
    var destinations: [String]?
    var firstAppearance: String?
    var comments: String
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, region: Region? = nil, sector: String? = nil, system: String? = nil, capital: String? = nil, destinations: [String]? = nil, firstAppearance: String? = nil, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.region = region
        self.sector = sector
        self.system = system
        self.capital = capital
        self.destinations = destinations
        self.firstAppearance = firstAppearance
        self.comments = comments
        
        super.init(recordType: "Planet", tableName: "planets", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Planet(name: "Tatooine", region: .outerRim, sector: "Arkanis", system: "Tatoo", capital: "Mos Eisley", destinations: ["Anchorhead", "Bestine", "Freetown", "Mos Espa"], firstAppearance: "A New Hope", comments: "Tatooine was a sparsely inhabited circumbinary desert planet located in the galaxy's Outer Rim Territories. Part of a binary star system, the planet orbited two scorching suns, resulting in the world lacking the necessary surface water to sustain large populations. As a result, many residents of the planet instead drew water from the atmosphere via moisture farms. The planet also had little surface vegetation. It was the homeworld to the native Jawa and Tusken Raider species and of Anakin and Luke Skywalker, who would go on to shape galactic history.")
    
    static func == (lhs: Planet, rhs: Planet) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
