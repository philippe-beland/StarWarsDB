import Foundation

/// Represents a droid in the Star Wars universe
@Observable
final class Droid: TrackableEntity {
    let id: UUID
    var name: String
    var comments: String?
    var firstAppearance: String
    
    /// The droid's classification type (e.g., "Astromech", "Protocol", "Battle")
    ///
    /// This indicates the droid's primary function and capabilities. For example:
    /// - Astromech droids specialize in starship maintenance and navigation
    /// - Protocol droids focus on translation and diplomatic functions
    /// - Battle droids are designed for combat operations
    
    var classType: String? ///TODO: Change to DroidType

    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let displayName: String = "Droids"

    let recordType: String = "Droid"
    let databaseTableName: String = "droids"
    static let sourceRecordType: String = "SourceDroids"
    static let sourceDatabaseTableName: String = "source_droids"
    
    init(name: String, classType: String?, firstAppearance: String?, comments: String?) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.firstAppearance = firstAppearance ?? ""
        self.classType = classType
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case classType = "class_type"
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Droid.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType)
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Droid.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(classType, forKey: .classType)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example: Droid = Droid(
        name: "R2 astromech droid",
        classType: "Astromech droid",
        firstAppearance: nil,
        comments: "Astromech droid with a high degree of mechanical aptitude."
    )
    static let empty: Droid = Droid(name: "", classType: nil, firstAppearance: nil, comments: nil)

    static func == (lhs: Droid, rhs: Droid) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, sort: String, filter: String) async -> [Droid] {
        // Droid-specific loading logic
        return await loadDroids(serie: serie, sort: sort, filter: filter)
    }
}
