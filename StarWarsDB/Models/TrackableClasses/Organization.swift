import Foundation

/// Represents an organization in the Star Wars universe
///
/// Organizations can be various types of groups including:
/// - Military forces (e.g., Rebel Alliance, Imperial Navy)
/// - Political entities (e.g., Galactic Senate, First Order)
/// - Criminal syndicates (e.g., Hutt Cartel, Black Sun)
/// - Commercial enterprises (e.g., Trade Federation)
/// - Religious orders (e.g., Jedi Order, Sith)
@Observable
final class Organization: TrackableEntity {
    let id: UUID
    var name: String
    var comments: String?
    var firstAppearance: String
    
    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let displayName: String = "Organizations"
    static let htmlTag: String = "p#app_organizations"

    let recordType: String = "Organization"
    let databaseTableName: String = "organizations"
    static let sourceRecordType: String = "SourceOrganizations"
    static let sourceDatabaseTableName: String = "source_organizations"
    
    init(name: String, firstAppearance: String?, comments: String?) {
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
        let container: KeyedDecodingContainer<Organization.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Organization.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(self.firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example: Organization = Organization(
        name: "Alphabet Squadron",
        firstAppearance: nil,
        comments: "The best squadron ever"
    )
    
    static let empty: Organization = Organization(
        name: "",
        firstAppearance: nil,
        comments: nil
    )

    static func == (lhs: Organization, rhs: Organization) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, filter: String) async -> [Organization] {
        await loadOrganizations(serie: serie, filter: filter)
    }
}
