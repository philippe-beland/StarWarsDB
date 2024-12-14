//
//  SourceStarship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceStarship: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var starship: Starship
    var appearance: AppearanceType
    
    init(source: Source, starship: Starship, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.starship = starship
        self.appearance = appearance
        
        super.init(recordType: "SourceStarships", tableName: "source_starships", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceStarship(source: .example, starship: .example, appearance: .mentioned)
    
    static func == (lhs: SourceStarship, rhs: SourceStarship) -> Bool {
        lhs.source == rhs.source && lhs.starship == rhs.starship
    }
}
