//
//  Fact.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class Fact: Codable, Identifiable, Observable {
    let ID: String
    var text: String
    var keywords: [String]
    
    init(id: String, text: String, keywords: [String]) {
        self.ID = id
        self.text = text
        self.keywords = keywords
    }
    
    static let example = Fact(id: "1", text: "Battle for the Force", keywords: ["Star Wars"])
}
