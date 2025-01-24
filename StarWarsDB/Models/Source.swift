//
//  Source.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents different eras in the Star Wars timeline
///
/// The Star Wars saga spans thousands of years, divided into distinct eras that mark
/// major historical periods and turning points in the galaxy's history.
enum Era: String, Decodable, CaseIterable {
    /// The ancient beginnings of the Jedi Order (~25,000 BBY)
    case dawnJedi = "Dawn of the Jedi"
    /// The height of the ancient Republic (~25,000 - 1000 BBY)
    case oldRepublic = "Old Republic"
    /// The golden age of the Galactic Republic (~300 BBY)
    case highRepublic = "High Republic"
    /// The decline of the Republic and rise of the Empire (~32-19 BBY)
    case fallJedi = "Fall of the Jedi"
    /// The period of Imperial control (~19-5 BBY)
    case reignEmpire = "Reign of the Empire"
    /// The Rebel Alliance's fight against the Empire (~5 BBY-4 ABY)
    case ageRebellion = "Age of Rebellion"
    /// The restoration of the Republic (~4-34 ABY)
    case newRepublic = "New Republic"
    /// The emergence of the First Order (~34-35 ABY)
    case riseFirstOrder = "Rise of the First Order"
    /// The era following the Galactic Civil War (~35+ ABY)
    case newJediOrder = "New Jedi Order"
    
    /// The earliest year in the era (BBY/ABY)
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
    
    /// The latest year in the era (BBY/ABY)
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

/// Types of Star Wars media content
enum SourceType: String, Decodable, CaseIterable, Hashable {
    /// All types of content
    case all = "All"
    /// Feature films
    case movies = "Movie"
    /// Comic books and graphic novels
    case comics = "Comic Book"
    /// Full-length novels
    case novels = "Novel"
    /// Brief stories and novellas
    case shortStory = "Short Story"
    /// Television series
    case tvShow = "TV Serie"
    /// Interactive video games
    case videoGame = "Video Game"
}

/// Options for sorting source content
enum SortingSourceOrder: String, CaseIterable {
    /// Sort by real-world release date
    case publicationDate = "publication_date"
    /// Sort by in-universe chronological order
    case universeYear = "universe_year"
}

/// Provides shared date formatting functionality
class DateFormatterProvider {
    /// Shared instance for consistent date formatting
    static let shared = DateFormatterProvider()
    
    /// Date formatter configured for source dates
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private init() {}
}

/// Represents a piece of Star Wars media content
///
/// Sources are the individual pieces of media that make up the Star Wars universe,
/// such as movies, TV episodes, comics, novels, etc. Each source is categorized by
/// type, era, and can be part of a larger series or story arc.
@Observable
class Source: DataNode, Record, Hashable {
    /// Unique identifier
    let id: UUID
    
    /// Title or name of the source
    var name: String
    
    /// Series this source belongs to (if any)
    var serie: Serie?
    
    /// Position within the series (if applicable)
    var number: Int?
    
    /// Story arc this source is part of (if any)
    var arc: Arc?
    
    /// Historical era in the Star Wars timeline
    var era: Era
    
    /// Type of media content
    var sourceType: SourceType
    
    /// Real-world release date
    var publicationDate: Date
    
    /// Year in the Star Wars timeline (BBY/ABY)
    var universeYear: Float
    
    /// Length in pages (if applicable)
    var numberPages: Int?
    
    /// Whether the source has been completed/consumed
    var isDone: Bool
    
    /// Additional notes about the source
    var comments: String
    
    /// Wookieepedia URL for this source
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    /// Keys used for encoding and decoding source data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source title
        case name
        /// Associated series
        case serie
        /// Position in series
        case number
        /// Associated story arc
        case arc
        /// Historical era
        case era
        /// Media type
        case sourceType = "source_type"
        /// Release date
        case publicationDate = "publication_date"
        /// Timeline year
        case universeYear = "universe_year"
        /// Content length
        case numberPages = "number_pages"
        /// Completion status
        case isDone = "is_done"
        /// Additional notes
        case comments
    }
    
    /// Creates a new source
    /// - Parameters:
    ///   - name: Title of the source
    ///   - serie: Series this source belongs to
    ///   - number: Position in the series
    ///   - arc: Story arc this source is part of
    ///   - era: Historical era in timeline
    ///   - sourceType: Type of media content
    ///   - publicationDate: Release date
    ///   - universeYear: Year in Star Wars timeline
    ///   - numberPages: Length in pages
    ///   - comments: Additional notes
    ///   - isDone: Completion status
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
    
    /// Creates a source from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
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
    
    /// Encodes the source into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
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
    
    /// An example source for previews and testing
    ///
    /// Star Wars: Episode IV - A New Hope was the first Star Wars film released,
    /// introducing audiences to the galaxy far, far away in 1977.
    static let example = Source(
        name: "Episode IV: A New Hope",
        serie: .example,
        number: 1,
        arc: .example,
        era: .ageRebellion,
        sourceType: .movies,
        publicationDate: Date(),
        universeYear: 0,
        numberPages: 200,
        comments: nil,
        isDone: false
    )
    
    /// Multiple example sources for previews and testing
    static let examples = [
        Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, numberPages: 200, comments: nil, isDone: false),
        Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, numberPages: 200, comments: nil, isDone: false),
        Source(name: "Episode IV: A New Hope", serie: .example, number: 1, arc: .example, era: .ageRebellion, sourceType: .movies, publicationDate: Date(), universeYear: 0, numberPages: 200, comments: nil, isDone: false)
    ]
    
    /// An empty source for initialization
    static let empty = Source(
        name: "",
        serie: .empty,
        number: nil,
        arc: .empty,
        era: .ageRebellion,
        sourceType: .comics,
        publicationDate: Date(),
        universeYear: nil,
        numberPages: nil,
        comments: nil,
        isDone: false
    )
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
