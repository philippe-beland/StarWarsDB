//
//  Starship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Starship: DataNode, Record {
    let id: UUID
    var name: String
    var model: StarshipModel?
    var comments: String?
    
    init(name: String, model: StarshipModel?, comments: String?) {
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
}
