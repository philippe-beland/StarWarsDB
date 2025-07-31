import Foundation

/// Represents miscellaneous items and concepts in the Star Wars universe
///
/// Varia encompasses elements that don't fit into other specific categories,
/// such as games (like Sabacc), technologies, cultural practices, or other
/// notable aspects of the Star Wars universe that aren't characters,
/// vehicles, or locations.
@Observable
final class Varia: TrackableEntity {
    let id: UUID
    var name: String
    var comments: String?
    var firstAppearance: String

    let recordType: String = "Varia"
    let databaseTableName: String = "varias"
    static let sourceRecordType: String = "SourceVarias"
    static let sourceDatabaseTableName: String = "source_varias"

    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let displayName: String = "Varias"
    
    init(name: String, firstAppearance: String?, comments: String? = nil) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.firstAppearance = firstAppearance ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Varia.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Varia.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example: Varia = Varia(
        name: "Sabacc",
        firstAppearance: nil,
        comments: "Card Game"
    )
    
    static let empty: Varia = Varia(
        name: "",
        firstAppearance: nil,
        comments: nil
    )

    static func == (lhs: Varia, rhs: Varia) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, filter: String) async -> [Varia] {
        await loadVarias(serie: serie, filter: filter)
    }
}
