//
//  Droid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Droid: DataNode, Record, Hashable {
    let id: UUID
    var name: String
    var comments: String
    var firstAppearance: String?
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, firstAppearance: String?, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.firstAppearance = firstAppearance
        self.comments = comments
        
        super.init(recordType: "Droid", tableName: "droids", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Droid(name: "R2 astromech droid", firstAppearance: nil, comments: "Astromech droid with a high degree of mechanical aptitude.")
    
    static func == (lhs: Droid, rhs: Droid) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
