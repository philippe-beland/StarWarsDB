//
//  SourceDroid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceDroid: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var entity: Droid
    var appearance: AppearanceType
    
    init(source: Source, entity: Droid, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.entity = entity
        self.appearance = appearance
        
        super.init(recordType: "SourceDroids", tableName: "source_droids", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
        SourceDroid(source: .example, entity: .example, appearance: .mentioned),
    ]
    
    static func == (lhs: SourceDroid, rhs: SourceDroid) -> Bool {
        lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
