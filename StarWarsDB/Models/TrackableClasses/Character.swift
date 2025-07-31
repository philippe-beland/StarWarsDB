import Foundation

enum Gender: String, Codable, CaseIterable {
    case Male
    case Female
    case Other
    case Unknown
}

@Observable
final class Character: TrackableEntity {
    let id: UUID
    var name: String
    var description: String = ""
    var comments: String?
    var firstAppearance: String
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

    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let displayName: String = "Characters"
    static let htmlTag: String = "p#app_characters"

    var recordType: String { "Character" }
    var databaseTableName: String { "characters" }
    static let sourceRecordType: String = "SourceCharacters"
    static let sourceDatabaseTableName: String = "source_characters"
    
    init(id: UUID = UUID(), name: String, aliases: [String], species: Species?, homeworld: Planet?, gender: Gender?, firstAppearance: String?, comments: String? = nil) {
        self.id = id
        self.name = name
        self.comments = comments
        self.firstAppearance = firstAppearance ?? ""
        self.aliases = aliases
        self.species = species
        self.homeworld = homeworld
        self.gender = gender ?? .Unknown
        //self.affiliations = affiliations
    }

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

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
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
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Character.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(aliases, forKey: .aliases)
        if let species = species, ![.example, .empty].contains(species) {
            try container.encode(species.id, forKey: .species)
        }
        if let homeworld = homeworld, ![.example, .empty].contains(homeworld) {
            try container.encode(homeworld.id, forKey: .homeworld)
        }
        try container.encode(gender, forKey: .gender)
        //try container.encode(affiliations, forKey: .affiliations)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Character(id: UUID(uuidString: "0c9b1708-799f-4277-b45c-c365029ce580") ?? UUID(), name: "Luke Skywalker", aliases: ["Red 5", "Red 4", "Red 3", "Red 2"], species: .example, homeworld: .example, gender: .Male, firstAppearance: nil)
    
    static let empty = Character(name: "", aliases: [], species: .empty, homeworld: .empty, gender: .Male, firstAppearance: nil)

    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, filter: String) async -> [Character] {
        await loadCharacters(serie: serie, filter: filter)
    }
}
