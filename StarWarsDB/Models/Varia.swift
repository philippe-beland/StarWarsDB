import Foundation

/// Represents miscellaneous items and concepts in the Star Wars universe
///
/// Varia encompasses elements that don't fit into other specific categories,
/// such as games (like Sabacc), technologies, cultural practices, or other
/// notable aspects of the Star Wars universe that aren't characters,
/// vehicles, or locations.
@Observable
class Varia: Entity {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, firstAppearance: String?, comments: String? = nil) {
        let id: UUID = UUID()

        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Varia", databaseTableName: "varias")
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Varia.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Varia", databaseTableName: "varias")
    }
    
    override func encode(to encoder: Encoder) throws {
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
}
