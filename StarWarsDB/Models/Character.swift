//
//  Character.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Character: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var aliases: String
    var species: Species?
    var homeworld: Planet?
    var sex: String
    var affiliation: [Organisation]
    var comments: String?
    var firstAppearance: String?
    var url: String
    
    
}
