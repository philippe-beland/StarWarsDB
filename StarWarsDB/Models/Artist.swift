//
//  Artist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Artist: DataNode, Record {
    let id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        
        super.init(recordType: "Artist", tableName: "artists", recordID: self.id)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Artist(id: "1", name: "Charles Soule")
    
}
