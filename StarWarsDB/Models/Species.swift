//
//  Species.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Species: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var homeworld: Planet?
    var image: String?
    var firstAppearance: String?
    var comments: String
    
    var url: URL
    }
