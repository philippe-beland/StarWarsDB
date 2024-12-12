//
//  Source.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

enum Era: String, Codable, CaseIterable {
    case dawnJedi
    case oldRepublic
    case highRepublic
    case fallJedi
    case reignEmpire
    case ageRebellion
    case newRepublic
    case riseFirstOrder
    case newJediOrder
}

enum sourceType: String, Codable, CaseIterable {
    case films
    case comics
    case novels
    case shortStory
    case tvShow
    case videoGame
    case referenceBook
}

class Source: Codable, Identifiable, Observable {
    let sourceID: String
    var name: String
    var serie: Serie?
    var number: Int?
    var arc: Arc?
    var era: Era
    var sourceType: sourceType
    var publicationDate: Date
    var authors: [Artist]
    var artists: [Artist]
    var numberPages: Int?
    var isDone: Bool
    
    var url: URL
}
