import Foundation

/// Represents an artist or creator in the Star Wars universe
///
/// Artists can be illustrators, directors, or other creative professionals other than writers
/// who have contributed to Star Wars media. This model is used to track their work
/// and contributions across different sources.
@Observable
final class Artist: CreatorEntity {
    let id: UUID
    var name: String
    var comments: String?
    var wookieepediaTitle: String = ""
    
    var alreadyInSource: Bool = false
    
    static let displayName: String = "Artists"
    let recordType: String = "Artist"
    let databaseTableName: String = "artists"
    static let sourceRecordType: String = "SourceArtists"
    static let sourceDatabaseTableName: String = "source_artists"

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
        let container: KeyedDecodingContainer<Artist.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
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
    
    static let example = Artist(name: "Charles Soule")
    static let empty = Artist(name: "")

    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func loadAll(serie: Serie?, filter: String) async -> [Artist] {
        await loadArtists(serie: serie, filter: filter)
    }
}
