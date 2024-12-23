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
    var source: Source
    var keywords: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case fact
        case source
        case keywords
    }
    
    init(fact: String, source: Source, keywords: [String]) {
        self.id = UUID()
        self.fact = fact
        self.source = source
        self.keywords = keywords
        
        super.init(recordType: "Fact", tableName: "facts", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.fact = try container.decode(String.self, forKey: .fact)
        self.source = try container.decode(Source.self, forKey: .source)
        self.keywords = try container.decode([String].self, forKey: .keywords)
        
        super.init(recordType: "Fact", tableName: "facts", recordID: self.id)
    }
    
    static let example = Fact(fact: "Battle for the Force", source: .example, keywords: ["Star Wars"])
}
