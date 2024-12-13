//
//  Organization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

class Organization: DataNode, Record {
    let id: String
    var name: String
    var comments: String?
    
    init(id: String, name: String, comments: String?) {
        self.id = id
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Organization", tableName: "organizations", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Organization(id: "1", name: "Alphabet Squadron", comments: "The best squadron ever")
}
