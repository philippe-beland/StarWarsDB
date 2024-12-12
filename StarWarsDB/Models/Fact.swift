//
//  Fact.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class Fact: Codable, Identifiable, Observable {
    let factID: String
    var text: String
    var keywords: [String]
}
