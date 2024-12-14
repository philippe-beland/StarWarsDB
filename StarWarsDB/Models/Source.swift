//
//  Source.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

enum Era: String, CaseIterable {
    case dawnJedi = "Dawn of the Jedi"
    case oldRepublic = "Old Republic"
    case highRepublic = "High Republic"
    case fallJedi = "Fall of the Jedi"
    case reignEmpire = "Reign of the Empire"
    case ageRebellion = "Age of Rebellion"
    case newRepublic = "New Republic"
    case riseFirstOrder = "Rise of the First Order"
    case newJediOrder = "New Jedi Order"
}

enum SourceType: String {
    case movies = "Movie"
    case comics = "Comic Book"
    case novels = "Novel"
    case shortStory = "Short Story"
    case tvShow = "TV Serie"
    case videoGame = "Video Game"
    case referenceBook = "Reference Book"
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
    var universeYear: Int?
    var authors: [Artist]
    var artists: [Artist]
    var numberPages: Int?
    var isDone: Bool
    var comments: String
    
    let dateFormatter = DateFormatter()
    
    var publicationDateString: String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: publicationDate)
        
        return dateString
    }
    
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, serie: Serie?, number: Int?, arc: Arc?, era: Era, sourceType: SourceType, publicationDate: Date, universeYear: Int?, authors: [Artist], artists: [Artist], numberPages: Int?, comments: String = "", isDone: Bool) {
        self.id = UUID()
        self.name = name
        self.serie = serie
        self.number = number
        self.arc = arc
        self.era = era
        self.sourceType = sourceType
        self.publicationDate = publicationDate
        self.universeYear = universeYear
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
    
    static let example = Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, authors: [.example], artists: [.example], numberPages: 200, isDone: false)
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
