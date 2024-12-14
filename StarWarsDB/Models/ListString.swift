//
//  ListString.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class StringName: Record {
    let id: UUID
    var name: String
    var comments: String
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(_ name: String, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.comments = comments
    }
}
