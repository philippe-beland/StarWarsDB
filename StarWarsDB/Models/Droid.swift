import Foundation

/// Represents a droid in the Star Wars universe
@Observable
class Droid: Entity {
    /// The droid's classification type (e.g., "Astromech", "Protocol", "Battle")
    ///
    /// This indicates the droid's primary function and capabilities. For example:
    /// - Astromech droids specialize in starship maintenance and navigation
    /// - Protocol droids focus on translation and diplomatic functions
    /// - Battle droids are designed for combat operations
    var classType: String? ///TODO: Change to DroidType
    
    init(name: String, classType: String?, firstAppearance: String?, comments: String?) {
        let id: UUID = UUID()
        self.classType = classType
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Droid", databaseTableName: "droids")
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
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Droid", databaseTableName: "droids")
    }
    
    override func encode(to encoder: Encoder) throws {
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
}
