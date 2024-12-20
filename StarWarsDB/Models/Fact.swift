//
//  Fact.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

@Observable
class Fact: DataNode {
    let id: UUID
    var fact: String
    var keywords: [String]
    
    init(fact: String, keywords: [String]) {
        self.id = UUID()
        self.fact = fact
        self.keywords = keywords
        
        super.init(recordType: "Fact", tableName: "facts", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Fact(fact: "Battle for the Force", keywords: ["Star Wars"])
}
