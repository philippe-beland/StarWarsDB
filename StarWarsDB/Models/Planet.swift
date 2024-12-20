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
class Planet: Entity {
    var region: Region?
    var sector: String?
    var fauna: String?
    var system: String?
    var capitalCity: String?
    var destinations: [StringName]
    var firstAppearance: String?
    
    init(name: String, region: Region? = nil, sector: String? = nil, system: String? = nil, fauna: String? = nil, capitalCity: String? = nil, destinations: [StringName], firstAppearance: String? = nil, image: String?, comments: String = "") {
        self.region = region
        self.sector = sector
        self.system = system
        self.fauna = fauna
        self.capitalCity = capitalCity
        self.destinations = destinations
        self.firstAppearance = firstAppearance
        
        super.init(name: name, comments: comments, image: image, recordType: "Planet", tableName: "planets")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Planet(name: "Tatooine", region: .outerRim, sector: "Arkanis", system: "Tatoo", capitalCity: "Mos Eisley", destinations: [StringName("Anchorhead"), StringName("Bestine"), StringName("Freetown"), StringName("Mos Espa")], firstAppearance: "A New Hope", image: "Tatooine", comments: "Tatooine was a sparsely inhabited circumbinary desert planet located in the galaxy's Outer Rim Territories. Part of a binary star system, the planet orbited two scorching suns, resulting in the world lacking the necessary surface water to sustain large populations. As a result, many residents of the planet instead drew water from the atmosphere via moisture farms. The planet also had little surface vegetation. It was the homeworld to the native Jawa and Tusken Raider species and of Anakin and Luke Skywalker, who would go on to shape galactic history.")
}
