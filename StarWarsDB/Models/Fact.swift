//
//  Fact.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class Fact: DataNode {
    let id: String
    var text: String
    var keywords: [String]
    
    init(id: String, text: String, keywords: [String]) {
        self.id = id
        self.text = text
        self.keywords = keywords
        
        super.init(recordType: "Fact", tableName: "facts", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Fact(id: "1", text: "Battle for the Force", keywords: ["Star Wars"])
}
