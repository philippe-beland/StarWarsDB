//
//  Droid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Droid: DataNode, Record {
    let id: UUID
    var name: String
    var comments: String?
    
    init(name: String, comments: String?) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Droid", tableName: "droids", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Droid(name: "R2 astromech droid", comments: "Astromech droid with a high degree of mechanical aptitude.")
}
