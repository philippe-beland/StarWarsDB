//
//  StarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class StarshipModel: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var comments: String?
    
    init(id: String, name: String, comments: String?) {
        self.ID = id
        self.name = name
        self.comments = comments
    }
    
    static let example = StarshipModel(id: "1", name: "YT-1300", comments: "Best ship!")
}
