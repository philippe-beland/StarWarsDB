//
//  Serie.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Serie: Entity {
    
    init(name: String, comments: String = "") {
        super.init(name: name, comments: comments, image: nil, recordType: "Serie", tableName: "series")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Serie(name: "Rebels", comments: "Series about the adventures of Ghost Squadron")
}
