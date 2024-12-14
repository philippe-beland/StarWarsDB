//
//  Starship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Starship: DataNode, Record, Hashable {
    let id: UUID
    var name: String
    var model: StarshipModel?
    var comments: String
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, model: StarshipModel?, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.model = model
        self.comments = comments
        
        super.init(recordType: "Starship", tableName: "starships", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Starship(name: "Millenium Falcon", model: .example, comments: "The best squadron ever")
    
    static func == (lhs: Starship, rhs: Starship) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
