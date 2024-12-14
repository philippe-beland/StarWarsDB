//
//  Creature.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Creature: DataNode, Record {
    let id: UUID
    var name: String
    var homeworld: Planet?
    
    var url: URL?
    
    init(name: String, homeworld: Planet?, url: URL?) {
        self.id = UUID()
        self.name = name
        self.homeworld = homeworld
        self.url = url
        
        super.init(recordType: "Creature", tableName: "creatures", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Creature(name: "Dianoga", homeworld: .example, url: nil)
    
}
