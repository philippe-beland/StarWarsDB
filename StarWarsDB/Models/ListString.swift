//
//  ListString.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class StringName: Record {
    let id: String = UUID().uuidString
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}
