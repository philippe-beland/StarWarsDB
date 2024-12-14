//
//  SourceCharacter.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceCharacter: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var character: Character
    var appearance: AppearanceType
    
    init(source: Source, character: Character, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.character = character
        self.appearance = appearance
        
        super.init(recordType: "SourceCharacter", tableName: "source_character", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceCharacter(source: .example, character: .example, appearance: .mentioned)
    
    static func == (lhs: SourceCharacter, rhs: SourceCharacter) -> Bool {
        lhs.source == rhs.source && lhs.character == rhs.character
    }
    
}
