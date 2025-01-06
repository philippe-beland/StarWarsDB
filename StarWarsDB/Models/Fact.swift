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
    
    init(fact: String, source: Source, keywords: [String] = []) {
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
        self.keywords = try container.decodeIfPresent([String].self, forKey: .keywords) ?? []
        
        super.init(recordType: "Fact", tableName: "facts", recordID: self.id)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(fact, forKey: .fact)
        try container.encode(source.id, forKey: .source)
        try container.encode(keywords, forKey: .keywords)
    }
    
    static let example = Fact(fact: "Battle for the Force", source: .example, keywords: ["Star Wars"])
    
    static let empty = Fact(fact: "", source: .example, keywords: [])
}
