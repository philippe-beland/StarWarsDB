import Foundation

/// Represents a starship design or class in the Star Wars universe
///
/// Starship models define the specifications and characteristics of a particular
/// type of vessel. Multiple individual starships can be of the same model, such as
/// how many YT-1300 light freighters exist besides the Millennium Falcon.
@Observable
final class StarshipModel: TrackableEntity {
    let id: UUID
    var name: String
    var comments: String?
    var firstAppearance: String
    var description: String = ""
    /// The vessel's classification (e.g., "Starfighter", "Capital Ship", "Freighter")
    var classType: String  ///TODO: Change to StarshipType
    
    /// The manufacturer's product line or series
    ///
    /// For example, the X-wing belongs to the "T-65" line of starfighters
    /// manufactured by Incom Corporation. //TODO: Change to Manufacturer?!?
    var line: String

    var alreadyInSource: Bool = false
    var wookieepediaTitle: String = ""
    var nbApparitions: Int = 0
    
    static let displayName: String = "Starship Models"
    static let htmlTag: String = "p#app_vehicles"

    let recordType: String = "StarshipModel"
    let databaseTableName: String = "starship_models"
    static let sourceRecordType: String = "SourceStarshipModels"
    static let sourceDatabaseTableName: String = "source_starship_models"
    
    init(name: String, classType: String?, line: String?, firstAppearance: String?, comments: String? = nil) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.firstAppearance = firstAppearance ?? ""
        self.classType = classType ?? ""
        self.line = line ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case classType = "class_type"
        case line
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<StarshipModel.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType) ?? ""
        self.line = try container.decodeIfPresent(String.self, forKey: .line) ?? ""
        self.firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance) ?? ""
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<StarshipModel.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(classType, forKey: .classType)
        try container.encode(line, forKey: .line)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example: StarshipModel = StarshipModel(
        name: "YT-1300",
        classType: "Starfighter",
        line: nil,
        firstAppearance: nil,
        comments: "Best ship!"
    )
    
    static let empty: StarshipModel = StarshipModel(
        name: "",
        classType: nil,
        line: nil,
        firstAppearance: nil,
        comments: nil
    )

    static func == (lhs: StarshipModel, rhs: StarshipModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, filter: String) async -> [StarshipModel] {
        await loadStarshipModels(serie: serie, filter: filter)
    }
}
