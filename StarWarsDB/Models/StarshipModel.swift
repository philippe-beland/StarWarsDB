//
//  StarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class StarshipModel: DataNode, Record {
    let id: String
    var name: String
    var comments: String?
    
    init(id: String, name: String, comments: String?) {
        self.id = id
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Starship Model", tableName: "starship_models", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = StarshipModel(id: "1", name: "YT-1300", comments: "Best ship!")
}
