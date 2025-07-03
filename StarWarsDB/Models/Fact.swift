import Foundation

/// Represents a factual piece of information from the Star Wars universe
@Observable
class Fact: DatabaseEntity, Identifiable {
    let id: UUID
    
    var fact: String
    var source: Source
    
    /// Keywords or tags associated with this fact for categorization and searching
    ///
    /// Keywords help organize and find related facts. They might include:
    /// - Character names
    /// - Locations
    /// - Events
    /// - Concepts or themes
    var keywords: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case fact
        case source
        case keywords
    }
    
    init(fact: String, source: Source, keywords: [String] = []) {
        self.id = UUID()
        self.fact = fact
        self.source = source
        self.keywords = keywords
        
        super.init(recordType: "Fact", databaseTableName: "facts", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Fact.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.fact = try container.decode(String.self, forKey: .fact)
        self.source = try container.decode(Source.self, forKey: .source)
        self.keywords = try container.decodeIfPresent([String].self, forKey: .keywords) ?? []
        
        super.init(recordType: "Fact", databaseTableName: "facts", recordID: self.id)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Fact.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(fact, forKey: .fact)
        try container.encode(source.id, forKey: .source)
        try container.encode(keywords, forKey: .keywords)
    }
    
    static let example = Fact(
        fact: "Battle for the Force",
        source: .example,
        keywords: ["Star Wars"]
    )

    static let empty = Fact(
        fact: "",
        source: .example,
        keywords: []
    )
}
