//
//  Artist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Artist: Entity {
    
    init(name: String, comments: String = "") {
        super.init(name: name, comments: comments, image: nil, recordType: "Artist", tableName: "artists")
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Artist(name: "Charles Soule")
}
