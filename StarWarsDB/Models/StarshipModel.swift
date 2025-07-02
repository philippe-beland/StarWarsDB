import Foundation

/// Represents a starship design or class in the Star Wars universe
///
/// Starship models define the specifications and characteristics of a particular
/// type of vessel. Multiple individual starships can be of the same model, such as
/// how many YT-1300 light freighters exist besides the Millennium Falcon.
@Observable
class StarshipModel: Entity {
    /// The vessel's classification (e.g., "Starfighter", "Capital Ship", "Freighter")
    var classType: String  ///TODO: Change to StarshipType
    
    /// The manufacturer's product line or series
    ///
    /// For example, the X-wing belongs to the "T-65" line of starfighters
    /// manufactured by Incom Corporation. //TODO: Change to Manufacturer?!?
    var line: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case classType = "class_type"
        case line
        case firstAppearance = "first_appearance"
        case comments
        case nbApparitions = "appearances"
    }
    
    init(name: String, classType: String?, line: String?, firstAppearance: String?, comments: String? = nil) {
        let id: UUID = UUID()
        
        self.classType = classType ?? ""
        self.line = line ?? ""
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Starship Model", databaseTableName: "starship_models")
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<StarshipModel.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType) ?? ""
        self.line = try container.decodeIfPresent(String.self, forKey: .line) ?? ""
        let firstAppearance: String? = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions: Int = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Starship Model", databaseTableName: "starship_models")
    }
    
    override func encode(to encoder: Encoder) throws {
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
}
