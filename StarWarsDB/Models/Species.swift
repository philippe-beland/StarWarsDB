//
//  Species.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Species: DataNode, Record {
    let id: UUID
    var name: String
    var homeworld: Planet?
    var image: String?
    var firstAppearance: String?
    var comments: String?
    
    var url: URL?
    
    init(name: String, homeworld: Planet?, image: String?, firstAppearance: String?, comments: String?, url: URL?) {
        self.id = UUID()
        self.name = name
        self.homeworld = homeworld
        self.image = image
        self.firstAppearance = firstAppearance
        self.comments = comments
        self.url = url
        
        super.init(recordType: "Species", tableName: "species", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Species(name: "Twi'lek", homeworld: .example, image: nil, firstAppearance: nil, comments: "The best squadron ever", url: nil)
}
