//
//  Source.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

enum Era: String, Decodable, CaseIterable {
    case dawnJedi = "Dawn of the Jedi"
    case oldRepublic = "Old Republic"
    case highRepublic = "High Republic"
    case fallJedi = "Fall of the Jedi"
    case reignEmpire = "Reign of the Empire"
    case ageRebellion = "Age of Rebellion"
    case newRepublic = "New Republic"
    case riseFirstOrder = "Rise of the First Order"
    case newJediOrder = "New Jedi Order"
    
    var minimum: Float {
        switch self {
        case .dawnJedi: -100000
        case .oldRepublic: -25000
        case .highRepublic: -500
        case .fallJedi: -100
        case .reignEmpire: -19
        case .ageRebellion: -5
        case .newRepublic: 5
        case .riseFirstOrder: 34
        case .newJediOrder: 35
        }
    }
    
    var maximum: Float {
        switch self {
        case .dawnJedi: -25
        case .oldRepublic: -500
        case .highRepublic: -100
        case .fallJedi: -19
        case .reignEmpire: -5
        case .ageRebellion: 4
        case .newRepublic: 34
        case .riseFirstOrder: 35
        case .newJediOrder: 100
        }
    }
    
}

enum SourceType: String, Decodable, CaseIterable, Hashable {
    case all = "All"
    case movies = "Movie"
    case comics = "Comic Book"
    case novels = "Novel"
    case shortStory = "Short Story"
    case tvShow = "TV Serie"
    case videoGame = "Video Game"
}

enum SortingSourceOrder: String, CaseIterable {
    case publicationDate = "publication_date"
    case universeYear = "universe_year"
}

class DateFormatterProvider {
    static let shared = DateFormatterProvider()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private init() {}
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
    var universeYear: Float
    var numberPages: Int?
    var isDone: Bool
    var comments: String
    
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case serie
        case number
        case arc
        case era
        case sourceType = "source_type"
        case publicationDate = "publication_date"
        case universeYear = "universe_year"
        case numberPages = "number_pages"
        case isDone = "is_done"
        case comments
    }
    
    init(name: String = "", serie: Serie?, number: Int?, arc: Arc?, era: Era, sourceType: SourceType, publicationDate: Date, universeYear: Float?, numberPages: Int?, comments: String?, isDone: Bool = false) {
        self.id = UUID()
        self.name = name
        self.serie = serie
        self.number = number
        self.arc = arc
        self.era = era
        self.sourceType = sourceType
        self.publicationDate = publicationDate
        self.universeYear = universeYear ?? era.minimum
        self.numberPages = numberPages
        self.comments = comments ?? ""
        self.isDone = isDone
        
        super.init(recordType: "Source", tableName: "sources", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.serie = try container.decodeIfPresent(Serie.self, forKey: .serie)
        self.number = try container.decodeIfPresent(Int.self, forKey: .number)
        self.arc = try container.decodeIfPresent(Arc.self, forKey: .arc)
        let era = try container.decode(Era.self, forKey: .era)
        self.era = era
        self.sourceType = try container.decode(SourceType.self, forKey: .sourceType)

        let publicationDate = try container.decode(String.self, forKey: .publicationDate)
        self.publicationDate = DateFormatterProvider.shared.dateFormatter.date(from: publicationDate) ?? Date()
        self.universeYear = try container.decodeIfPresent(Float.self, forKey: .universeYear) ?? era.minimum
        self.numberPages = try container.decodeIfPresent(Int.self, forKey: .numberPages)
        self.isDone = try container.decode(Bool.self, forKey: .isDone)
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments) ?? ""
        
        super.init(recordType: "Source", tableName: "sources", recordID: self.id)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if serie != .empty {
            try container.encode(serie?.id, forKey: .serie)
        }
        try container.encode(number, forKey: .number)
        if arc != .empty {
            try container.encode(arc?.id, forKey: .arc)
        }
        try container.encode(era.rawValue, forKey: .era)
        try container.encode(sourceType.rawValue, forKey: .sourceType)
        try container.encode(publicationDate, forKey: .publicationDate)
        try container.encode(universeYear, forKey: .universeYear)
        try container.encode(numberPages, forKey: .numberPages)
        try container.encode(isDone, forKey: .isDone)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, numberPages: 200, comments: nil, isDone: false)
    
    static let examples = [
        Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, numberPages: 200, comments: nil, isDone: false),
        Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, numberPages: 200, comments: nil, isDone: false),
        Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, numberPages: 200, comments: nil, isDone: false)
    ]
    
    static let empty = Source(name: "", serie: .empty, number: nil, arc: .empty, era: .ageRebellion, sourceType: .comics, publicationDate: Date(), universeYear: nil, numberPages: nil, comments: nil, isDone: false)
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
