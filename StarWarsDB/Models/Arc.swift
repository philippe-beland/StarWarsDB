import Foundation

/// Represents a story arc in the Star Wars universe
@Observable
class Arc: Entity {
    /// The series this arc belongs to
    var serie: Serie?
    
    init(name: String, serie: Serie, comments: String?) {
        let id: UUID = UUID()
        self.serie = serie
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Arc", databaseTableName: "arcs")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        /// Associated series
        case serie
        case comments
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.serie = try container.decodeIfPresent(Serie.self, forKey: .serie)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Arc", databaseTableName: "arcs")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Arc.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if serie != nil {
            try container.encode(serie?.id, forKey: .serie)
        }
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Arc(name: "Battle for the Force", serie: .example, comments: nil)
    static let empty = Arc(name: "", serie: .empty, comments: nil)
}
