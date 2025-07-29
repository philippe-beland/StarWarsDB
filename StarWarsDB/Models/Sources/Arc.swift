import Foundation

/// Represents a story arc in the Star Wars universe
@Observable
final class Arc: BaseEntity {    
    let id: UUID
    var name: String
    var comments: String?
    var serie: Serie?
    var wookieepediaTitle: String = ""
    
    static let displayName: String = "Arcs"
    var alreadyInSource: Bool = false

    var recordType: String { "Arc" }
    var databaseTableName: String { "arcs" }
    
    init(name: String, serie: Serie, comments: String? = nil) {
        self.id = UUID()
        self.name = name
        self.comments = comments
        self.serie = serie
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case comments
        case serie
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
        self.serie = try container.decodeIfPresent(Serie.self, forKey: .serie)
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Arc.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(comments, forKey: .comments)
        if serie != nil {
            try container.encode(serie?.id, forKey: .serie)
        }
    }
    
    static let example = Arc(name: "Battle for the Force", serie: .example, comments: nil)
    static let empty = Arc(name: "", serie: .empty, comments: nil)

    static func == (lhs: Arc, rhs: Arc) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func loadAll(serie: Serie?, sort: String, filter: String) async -> [Arc] {
        // Droid-specific loading logic
        return await loadArcs(sort: sort, filter: filter)
    }
}
