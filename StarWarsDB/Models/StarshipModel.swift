//
//  StarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class StarshipModel: Codable, Identifiable, Observable {
    let ID: String
    var name: String
    var comments: String?
}
