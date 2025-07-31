import Foundation

/// Represents a series (comic book, TV show, novel, etc.) of related Star Wars media content
@Observable
final class Serie: BaseEntity {
    let id: UUID
    var name: String
    var comments: String?
    var sourceType: SourceType
    
    var wookieepediaTitle: String = ""
    
    static let displayName: String = "Series"
    var alreadyInSource: Bool = false

    let recordType: String = "Serie"
    let databaseTableName: String = "series"
    
    init(name: String, sourceType: SourceType, comments: String?) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.sourceType = sourceType
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sourceType = "source_type"
        case comments
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Serie.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.sourceType = try container.decode(SourceType.self, forKey: .sourceType)
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Serie.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sourceType.rawValue, forKey: .sourceType)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Serie(
        name: "Rebels",
        sourceType: .tvShow,
        comments: "Series about the adventures of Ghost Squadron"
    )
    
    static let empty = Serie(
        name: "",
        sourceType: .tvShow,
        comments: nil
    )

    static func == (lhs: Serie, rhs: Serie) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, filter: String) async -> [Serie] {
        await loadSeries(filter: filter)
    }
}
