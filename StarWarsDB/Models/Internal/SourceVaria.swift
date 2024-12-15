//
//  SourceVaria.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceVaria: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var entity: Varia
    var appearance: AppearanceType
    
    init(source: Source, entity: Varia, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.entity = entity
        self.appearance = appearance
        
        super.init(recordType: "SourceVarias", tableName: "source_varias", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
        SourceVaria(source: .example, entity: .example, appearance: .mentioned),
    ]
    
    static func == (lhs: SourceVaria, rhs: SourceVaria) -> Bool {
        lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
