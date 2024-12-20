//
//  Arc.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Arc: Entity {
    var serie: Serie
    
    init(name: String, serie: Serie, comments: String = "") {
        self.serie = serie
        
        super.init(name: name, comments: comments, image: nil, recordType: "Arc", tableName: "arcs")
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Arc(name: "Battle for the Force", serie: .example)
}
