//
//  Creature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Creature: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    
}
