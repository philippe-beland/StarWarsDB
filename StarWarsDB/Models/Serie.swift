import Foundation

/// Represents a series (comic book, TV show, novel, etc.) of related Star Wars media content
@Observable
class Serie: Entity {
    var sourceType: SourceType
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sourceType = "source_type"
        case comments
    }
    
    init(name: String, sourceType: SourceType, comments: String?) {
        let id: UUID = UUID()
        self.sourceType = sourceType
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Serie", databaseTableName: "series")
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Serie.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.sourceType = try container.decode(SourceType.self, forKey: .sourceType)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Serie", databaseTableName: "series")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Serie.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sourceType.rawValue, forKey: .sourceType)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Serie(
        name: "Rebels",
        sourceType: .tvShow,
        comments: "Series about the adventures of Ghost Squadron"
    )
    
    static let empty = Serie(
        name: "",
        sourceType: .tvShow,
        comments: nil
    )
}
