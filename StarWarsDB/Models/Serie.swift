//
//  Serie.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Serie: DataNode, Record, Hashable {
    let id: UUID
    var name: String
    var comments: String
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Serie", tableName: "series", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Serie(name: "Star Wars Rebels", comments: "Series about the adventures of Ghost Squadron")
    
    static func == (lhs: Serie, rhs: Serie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
