import Foundation

/// Tracks named starship appearances in Star Wars media sources
@Observable
class SourceStarship: SourceEntity {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity
        case appearance
        case number = "nb_appearances"
    }
    
    init(source: Source, entity: Starship, appearance: AppearanceType, number: Int = 0) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceStarships", databaseTableName: "source_starships")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Starship.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        let number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
        
        // Convert numeric appearance type to enum
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, number: number, recordType: "SourceStarships", databaseTableName: "source_starships")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }
    
    static let example = [
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
        SourceStarship(source: .example, entity: .example, appearance: .mentioned),
    ]
}
