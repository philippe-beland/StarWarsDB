import Foundation

/// Represents a creature in the Star Wars universe
///
/// Creatures are non-humanoid life forms that can be either sentient or non-sentient.
@Observable
final class Creature: TrackableEntity {
    let id: UUID
    var name: String
    var comments: String?
    var firstAppearance: String
    
    /// The creature's sentience designation (e.g., "Sentient", "Non-sentient")
    var designation: String? ///TODO: Change to SentienceType
    
    /// The creature's home planet
    var homeworld: Planet?

    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let exampleImageName: String = "Dianoga"
    static let displayName: String = "Creatures"

    let recordType: String = "Creature"
    let databaseTableName: String = "creatures"
    static let sourceRecordType: String = "SourceCreatures"
    static let sourceDatabaseTableName: String = "source_creatures"
    
    init(name: String, designation: String?, homeworld: Planet?, firstAppearance: String?, comments: String?) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.firstAppearance = firstAppearance ?? ""
        self.designation = designation
        self.homeworld = homeworld
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case designation
        case homeworld
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Creature.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.designation = try container.decodeIfPresent(String.self, forKey: .designation)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Creature.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(designation, forKey: .designation)
        if homeworld != nil && homeworld != .example {
            try container.encode(homeworld?.id, forKey: .homeworld)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Creature(name: "Dianoga", designation: "Non-sentient", homeworld: .example, firstAppearance: nil, comments: nil)
    static let empty = Creature(name: "", designation: "", homeworld: nil, firstAppearance: nil, comments: nil)

    static func == (lhs: Creature, rhs: Creature) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, sort: String, filter: String) async -> [Creature] {
        // Creature-specific loading logic
        return await loadCreatures(serie: serie, sort: sort, filter: filter)
    }
}
