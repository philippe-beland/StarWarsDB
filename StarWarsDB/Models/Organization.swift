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
class Organization: Entity {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, firstAppearance: String?, comments: String?) {
        let id: UUID = UUID()
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Organization", databaseTableName: "organizations")
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Organization.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Organization", databaseTableName: "organizations")
    }
    
    override func encode(to encoder: Encoder) throws {
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
}
