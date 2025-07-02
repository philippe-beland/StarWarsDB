import Foundation

/// Represents a specific starship in the Star Wars universe
///
/// While StarshipModel represents a class or type of vessel, Starship represents
/// individual vessels. For example, while YT-1300 is a starship model, the
/// Millennium Falcon is a specific starship of that model with its own history
/// and characteristics.
@Observable
class Starship: Entity {
    var model: StarshipModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case model
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, model: StarshipModel?, firstAppearance: String?, comments: String? = nil) {
        let id: UUID = UUID()
        self.model = model
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Starship", databaseTableName: "starships")
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Starship.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.model = try container.decodeIfPresent(StarshipModel.self, forKey: .model)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Starship", databaseTableName: "starships")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Starship.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if model != nil && model != .example {
            try container.encode(model?.id, forKey: .model)
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
}
