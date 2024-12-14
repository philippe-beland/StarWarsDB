//
//  Species.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Species: DataNode, Record, Hashable {
    let id: UUID
    var name: String
    var homeworld: Planet?
    var image: String?
    var firstAppearance: String?
    var comments: String
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, homeworld: Planet?, image: String?, firstAppearance: String?, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.homeworld = homeworld
        self.image = image
        self.firstAppearance = firstAppearance
        self.comments = comments
        
        super.init(recordType: "Species", tableName: "species", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Species(name: "Twi'lek", homeworld: .example, image: nil, firstAppearance: nil)
    
    static func == (lhs: Species, rhs: Species) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
