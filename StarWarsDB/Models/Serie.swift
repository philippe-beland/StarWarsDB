//
//  Serie.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Serie: DataNode, Record {
    let id: String
    var name: String
    var comments: String?
    
    init(id: String, name: String, comments: String?) {
        self.id = id
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Serie", tableName: "series", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Serie(id: "1", name: "Star Wars Rebels", comments: "Series about the adventures of Ghost Squadron")
}
