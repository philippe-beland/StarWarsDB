import Foundation

/// Represents a sentient species in the Star Wars universe
@Observable
class Species: Entity {
    var homeworld: Planet?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case homeworld
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, homeworld: Planet?, firstAppearance: String?, comments: String? = nil) {
        let id: UUID = UUID()
        self.homeworld = homeworld
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Species", databaseTableName: "species")
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Species.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Species", databaseTableName: "species")
    }
    
    override func encode(to encoder: Encoder) throws {
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
}
