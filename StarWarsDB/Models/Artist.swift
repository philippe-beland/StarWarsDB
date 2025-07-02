import Foundation

/// Represents an artist or creator in the Star Wars universe
///
/// Artists can be illustrators, directors, or other creative professionals other than writers
/// who have contributed to Star Wars media. This model is used to track their work
/// and contributions across different sources.
@Observable
class Artist: Entity {

    init(name: String, comments: String? = nil) {
        let id: UUID = UUID()
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Artist", databaseTableName: "artists")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case comments
    }
    
    required init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Artist.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Artist", databaseTableName: "artists")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(comments, forKey: .comments)
    }
    
    static let example = Artist(name: "Charles Soule")
    static let empty = Artist(name: "")
}
