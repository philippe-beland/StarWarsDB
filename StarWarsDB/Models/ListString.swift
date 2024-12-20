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
    
    static func == (lhs: StringName, rhs: StringName) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
