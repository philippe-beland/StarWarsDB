import Foundation

/// Represents an author in the Star Wars universe
///
/// Authors are the writers of Star Wars media. This model is used to track their work
/// and contributions across different sources.
@Observable
final class Author: CreatorEntity {
    let id: UUID
    var name: String
    var comments: String?
    var wookieepediaTitle: String = ""
    
    var alreadyInSource: Bool = false
    
    static let displayName: String = "Artists"

    let recordType: String = "Author"
    let databaseTableName: String = "artists"
    static let sourceRecordType: String = "SourceAuthors"
    static let sourceDatabaseTableName: String = "source_authors"

    init(name: String, comments: String? = nil) {
        self.id = UUID()
        self.name = name
        self.comments = comments
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case comments
    }
    
    required init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Author.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Author(name: "Charles Soule")
    static let empty = Author(name: "")

    static func == (lhs: Author, rhs: Author) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, sort: String, filter: String) async -> [Author] {
        // Author-specific loading logic
        return await loadAuthors(sort: sort, filter: filter)
    }
}
