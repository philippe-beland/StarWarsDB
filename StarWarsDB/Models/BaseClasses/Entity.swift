import Foundation

/// Base class for Star Wars universe entities
///
/// Entity provides common properties and behavior for all trackable elements
/// in the Star Wars universe. This includes basic identification, naming,
/// and appearance tracking shared by all entity types.
@Observable
class Entity: DatabaseEntity, NamedEntity {
    var recordType: String
    var databaseTableName: String
    
    var id: UUID
    var name: String
    var comments: String
    var nbApparitions: Int
    var firstAppearance: String
    
    var isExisting: Bool = false
    
    var wookieepediaTitle: String = ""
    var url: URL? {
        let title = wookieepediaTitle.isEmpty ? name : wookieepediaTitle
        let encodedTitle = title.replacingOccurrences(of: " ", with: "_")
        return URL(string: "https://starwars.fandom.com/wiki/" + encodedTitle)
    }
    
    init(id: UUID, name: String, comments: String?, firstAppearance: String?, nbApparitions: Int = 0, recordType: String, databaseTableName: String) {
        self.id = id
        self.name = name
        self.comments = comments ?? ""
        self.firstAppearance = firstAppearance ?? ""
        self.nbApparitions = nbApparitions
        self.recordType = recordType
        self.databaseTableName = databaseTableName
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    /// Compares two entities for equality
    /// - Returns: True if both entities have the same ID
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.id == rhs.id
    }
    
    /// Generates a hash value for the entity
    /// - Parameter hasher: The hasher to use
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }

    func isValid(for type: EntityType) -> Bool {
        switch type {
        case .character:
            return self is Character
        case .creature:
            return self is Creature
        case .droid:
            return self is Droid
        case .organization:
            return self is Organization
        case .planet:
            return self is Planet
        case .species:
            return self is Species
        case .starship:
            return self is Starship
        case .starshipModel:
            return self is StarshipModel
        case .varia:
            return self is Varia
        case .arc:
            return self is Arc
        case .serie:
            return self is Serie
        case .artist:
            return self is Artist
        case .author:
            return self is Artist
        }
    }
}
