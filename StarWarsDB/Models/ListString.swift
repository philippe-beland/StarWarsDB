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
    
    init(_ name: String) {
        self.id = UUID()
        self.name = name
    }
}
