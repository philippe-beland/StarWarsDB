//
//  Varia.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Varia: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var url: String?
    var comments: String?
    
    init(id: String, name: String, url: String?, comments: String?) {
        self.ID = id
        self.name = name
        self.url = url
        self.comments = comments
    }
    
    static let example = Varia(id: "1", name: "Sabacc", url: nil, comments: "Card Game")
    
}
