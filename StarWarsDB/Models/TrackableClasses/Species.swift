import Foundation

/// Represents a sentient species in the Star Wars universe
@Observable
final class Species: TrackableEntity {
    let id: UUID
    var name: String
    var comments: String?
    var firstAppearance: String
    var homeworld: Planet?

    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let displayName: String = "Species"

    var recordType: String { "Species" }
    var databaseTableName: String { "species" }
    static let sourceRecordType: String = "SourceSpecies"
    static let sourceDatabaseTableName: String = "source_species"
    
    init(name: String, homeworld: Planet?, firstAppearance: String?, comments: String? = nil) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.firstAppearance = firstAppearance ?? ""
        self.homeworld = homeworld
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case homeworld
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Species.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Species.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if homeworld != nil && homeworld != .example {
            try container.encode(homeworld?.id, forKey: .homeworld)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Species(
        name: "Twi'lek",
        homeworld: .example,
        firstAppearance: nil
    )
    
    static let empty = Species(
        name: "",
        homeworld: .empty,
        firstAppearance: nil
    )

    static func == (lhs: Species, rhs: Species) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, sort: String, filter: String) async -> [Species] {
        // Species-specific loading logic
        return await loadSpecies(serie: serie, sort: sort, filter: filter)
    }
}
