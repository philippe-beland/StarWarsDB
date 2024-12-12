//
//  Planet.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Planet: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var region: String
    var sector: String
    var system: String
    var suns: Int
    var moons: Int
    var fauna: String
    var capital: String
    var terrain: String
    var languages: String
    var destinations: String
    var firstAppearance: String?
    var comments: String?
}
