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
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        
        super.init(recordType: "Arc", tableName: "arcs", recordID: self.id)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Arc(name: "Battle for the Force")
    
}
