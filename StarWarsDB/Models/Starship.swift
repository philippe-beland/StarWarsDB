//
//  Starship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Starship: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var model: StarshipModel?
    var comments: String?
}
