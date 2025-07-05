import Foundation

enum Gender: String, Codable, CaseIterable {
    case Male
    case Female
    case Other
    case Unknown
}

@Observable
class Character: Entity {
    var aliases: [String]
    var species: Species?
    var homeworld: Planet?
    var gender: Gender
    //var affiliations: [Organization]
    
    var alias: String {
        aliases.joined(separator: ", ")
    }
    
//    var affiliation: String {
//        var organizations: [String] = []
//        for org in affiliations{
//            organizations.append(org.name)
//        }
//         
//        return organizations.joined(separator: ", ")
//    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case aliases
        case species
        case homeworld
        case gender
        //case affiliations
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(id: UUID = UUID(), name: String, aliases: [String], species: Species?, homeworld: Planet?, gender: Gender?, firstAppearance: String?, comments: String? = nil) {
        self.aliases = aliases
        self.species = species
        self.homeworld = homeworld
        self.gender = gender ?? .Unknown
        //self.affiliations = affiliations
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Character", databaseTableName: "characters")
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        
        if let aliases: [String] = try container.decodeIfPresent([String].self, forKey: .aliases) {
            self.aliases = aliases
        } else {
            self.aliases = []
        }
        
        self.species = try container.decodeIfPresent(Species.self, forKey: .species)
        self.homeworld = try container.decodeIfPresent(Planet.self, forKey: .homeworld)
        self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender) ?? .Unknown
//        if let affiliations = try container.decodeIfPresent([Organization].self, forKey: .affiliations) {
//            self.affiliations = affiliations
//        } else {
//            self.affiliations = []
//        }
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Character", databaseTableName: "characters")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Character.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(aliases, forKey: .aliases)
        if species != nil && species != .example {
            try container.encode(species?.id, forKey: .species)
        }
        if homeworld != nil && homeworld != .example {
            try container.encode(homeworld?.id, forKey: .homeworld)
        }
        try container.encode(gender, forKey: .gender)
        //try container.encode(affiliations, forKey: .affiliations)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Character(id: UUID(uuidString: "0c9b1708-799f-4277-b45c-c365029ce580") ?? UUID(), name: "Luke Skywalker", aliases: ["Red 5", "Red 4", "Red 3", "Red 2"], species: .example, homeworld: .example, gender: .Male, firstAppearance: nil)
    
    static let examples = [
        Character(name: "Luke Skywalker", aliases: ["Red 5", "Red 4", "Red 3", "Red 2"], species: .example, homeworld: .example, gender: .Male, firstAppearance: nil),
        Character(name: "Luke Skywalker", aliases: ["Red 5", "Red 4", "Red 3", "Red 2"], species: .example, homeworld: .example, gender: .Male, firstAppearance: nil)]
    
    static let empty = Character(name: "", aliases: [], species: .empty, homeworld: .empty, gender: .Male, firstAppearance: nil)
}
