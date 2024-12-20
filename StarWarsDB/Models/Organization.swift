//
//  Organization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Organization: Entity {
    var firstAppearance: String?
    
    init(name: String, firstAppearance: String?, image: String?, comments: String = "") {
        
        super.init(name: name, comments: comments, image: image, recordType: "Organization", tableName: "organizations")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Organization(name: "Alphabet Squadron", firstAppearance: nil, image: "Alphabet_Squadron", comments: "The best squadron ever")
}
