//
//  Varia.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Varia: DataNode, Record {
    let id: UUID
    var name: String
    var url: String?
    var comments: String?
    
    init(name: String, url: String?, comments: String?) {
        self.id = UUID()
        self.name = name
        self.url = url
        self.comments = comments
        
        super.init(recordType: "Varia", tableName: "varias", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Varia(name: "Sabacc", url: nil, comments: "Card Game")
    
}
