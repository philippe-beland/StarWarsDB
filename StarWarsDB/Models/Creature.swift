import Foundation

/// Represents a creature in the Star Wars universe
///
/// Creatures are non-humanoid life forms that can be either sentient or non-sentient.
@Observable
class Creature: Entity {
    /// The creature's sentience designation (e.g., "Sentient", "Non-sentient")
    var designation: String? ///TODO: Change to SentienceType
    
    /// The creature's home planet
    var homeworld: Planet?
    
    init(name: String, designation: String?, homeworld: Planet?, firstAppearance: String?, comments: String?) {
        let id: UUID = UUID()
        self.designation = designation
        self.homeworld = homeworld
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Creature", databaseTableName: "creatures")
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
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.designation = try container.decodeIfPresent(String.self, forKey: .designation)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Creature", databaseTableName: "creatures")
    }
    
    override func encode(to encoder: Encoder) throws {
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
}
