//
//  SourceSpecies.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceSpecies: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var species: Species
    var appearance: AppearanceType
    
    init(source: Source, species: Species, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.species = species
        self.appearance = appearance
        
        super.init(recordType: "SourceSpecies", tableName: "source_species", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceSpecies(source: .example, species: .example, appearance: .mentioned)
    
    static func == (lhs: SourceSpecies, rhs: SourceSpecies) -> Bool {
        lhs.source == rhs.source && lhs.species == rhs.species
    }
}
