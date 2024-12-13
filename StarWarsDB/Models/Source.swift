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

enum SourceType: String, Codable, CaseIterable {
    case movies
    case comics
    case novels
    case shortStory
    case tvShow
    case videoGame
    case referenceBook
}

class Source: DataNode, Record {
    let id: String
    var name: String
    var serie: Serie?
    var number: Int?
    var arc: Arc?
    var era: Era
    var sourceType: SourceType
    var publicationDate: Date
    var authors: [Artist]
    var artists: [Artist]
    var numberPages: Int?
    var isDone: Bool
    
    var url: URL
    
    init(id: String, name: String, serie: Serie?, number: Int?, arc: Arc?, era: Era, sourceType: SourceType, publicationDate: Date, authors: [Artist], artists: [Artist], numberPages: Int?, isDone: Bool, url: URL) {
        self.id = id
        self.name = name
        self.serie = serie
        self.number = number
        self.arc = arc
        self.era = era
        self.sourceType = sourceType
        self.publicationDate = publicationDate
        self.authors = authors
        self.artists = artists
        self.numberPages = numberPages
        self.isDone = isDone
        self.url = url
        
        super.init(recordType: "Source", tableName: "sources", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Source(id: "1", name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), authors: [.example], artists: [.example], numberPages: 200, isDone: false, url: URL(string: "https://swapi.dev/api/films/1")!)
}
