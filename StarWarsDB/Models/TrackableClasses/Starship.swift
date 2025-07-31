import Foundation

/// Represents a specific starship in the Star Wars universe
///
/// While StarshipModel represents a class or type of vessel, Starship represents
/// individual vessels. For example, while YT-1300 is a starship model, the
/// Millennium Falcon is a specific starship of that model with its own history
/// and characteristics.
@Observable
final class Starship: TrackableEntity {
    let id: UUID
    var name: String
    var comments: String?
    var firstAppearance: String
    var model: StarshipModel?

    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let displayName: String = "Starships"

    var recordType: String { "Starship" }
    var databaseTableName: String { "starships" }
    static let sourceRecordType: String = "SourceStarships"
    static let sourceDatabaseTableName: String = "source_starships"
    
    init(name: String, model: StarshipModel?, firstAppearance: String?, comments: String? = nil) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.firstAppearance = firstAppearance ?? ""
        self.model = model
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case model
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Starship.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.model = try container.decodeIfPresent(StarshipModel.self, forKey: .model)
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Starship.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if let model = model, ![.example, .empty].contains(model) {
            try container.encode(model.id, forKey: .model)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Starship(
        name: "Millennium Falcon",
        model: .example,
        firstAppearance: nil,
        comments: "The fastest hunk of junk in the galaxy"
    )
    
    static let empty = Starship(
        name: "",
        model: nil,
        firstAppearance: nil,
        comments: ""
    )

    static func == (lhs: Starship, rhs: Starship) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, filter: String) async -> [Starship] {
        await loadStarships(serie: serie, filter: filter)
    }
}
