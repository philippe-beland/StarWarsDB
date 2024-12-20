//
//  Varia.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Varia: Entity {
    
    init(name: String, image: String?, comments: String = "") {
        super.init(name: name, comments: comments, image: image, recordType: "Varia", tableName: "varias")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Varia(name: "Sabacc", image: "Sabacc", comments: "Card Game")
}
