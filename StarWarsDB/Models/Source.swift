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

@Observable
class Source: DataNode, Record, Hashable {
    let id: UUID
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
    var comments: String
    
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, serie: Serie?, number: Int?, arc: Arc?, era: Era, sourceType: SourceType, publicationDate: Date, authors: [Artist], artists: [Artist], numberPages: Int?, comments: String = "", isDone: Bool) {
        self.id = UUID()
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
        self.comments = comments
        self.isDone = isDone
        
        super.init(recordType: "Source", tableName: "sources", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), authors: [.example], artists: [.example], numberPages: 200, isDone: false)
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
