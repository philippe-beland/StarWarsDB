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
    var comments: String?
    
    var url: URL?
    
    init(id: String, name: String, homeworld: Planet?, image: String?, firstAppearance: String?, comments: String?, url: URL?) {
        self.ID = id
        self.name = name
        self.homeworld = homeworld
        self.image = image
        self.firstAppearance = firstAppearance
        self.comments = comments
        self.url = url
    }
    
    static let example = Species(id: "1", name: "Twi'lek", homeworld: .example, image: nil, firstAppearance: nil, comments: "The best squadron ever", url: nil)
}
