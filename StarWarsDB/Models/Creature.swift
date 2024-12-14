//
//  Creature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Creature: DataNode, Record, Hashable {
    let id: UUID
    var name: String
    var homeworld: Planet?
    var firstAppearance: String?
    var comments: String
    
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, homeworld: Planet?, firstAppearance: String?, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.homeworld = homeworld
        self.firstAppearance = firstAppearance
        self.comments = comments
        
        super.init(recordType: "Creature", tableName: "creatures", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Creature(name: "Dianoga", homeworld: .example, firstAppearance: nil)
    
    static func == (lhs: Creature, rhs: Creature) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
}
