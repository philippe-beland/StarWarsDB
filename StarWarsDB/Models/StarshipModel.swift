//
//  StarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

@Observable
class StarshipModel: DataNode, Record {
    let id: UUID
    var name: String
    var comments: String?
    
    init(name: String, comments: String?) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Starship Model", tableName: "starship_models", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = StarshipModel(name: "YT-1300", comments: "Best ship!")
}
