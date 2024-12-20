//
//  Droid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Droid: Entity {
    var firstAppearance: String?
    
    init(name: String, firstAppearance: String?, image: String?, comments: String = "") {
        self.firstAppearance = firstAppearance
        
        super.init(name: name, comments: comments, image: image, recordType: "Droid", tableName: "droids")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Droid(name: "R2 astromech droid", firstAppearance: nil, image: "R2_astromech_droid", comments: "Astromech droid with a high degree of mechanical aptitude.")
}
