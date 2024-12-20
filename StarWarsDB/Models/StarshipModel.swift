//
//  StarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

@Observable
class StarshipModel: Entity {
    var firstAppearance: String?
    
    init(name: String, firstAppearance: String?, image: String?, comments: String = "") {
        
        super.init(name: name, comments: comments, image: image, recordType: "Starship Model", tableName: "starship_models")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = StarshipModel(name: "YT-1300", firstAppearance: nil, image: "YT-1300", comments: "Best ship!")
}
