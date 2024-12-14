//
//  Arc.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Arc: DataNode, Record {
    let id: UUID
    var name: String
    var comments: String
    
    init(name: String, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Arc", tableName: "arcs", recordID: self.id)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Arc(name: "Battle for the Force")
    
}
