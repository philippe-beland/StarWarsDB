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
    var droid: Droid
    var appearance: AppearanceType
    
    init(source: Source, droid: Droid, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.droid = droid
        self.appearance = appearance
        
        super.init(recordType: "SourceDroids", tableName: "source_droids", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceDroid(source: .example, droid: .example, appearance: .mentioned)
    
    static func == (lhs: SourceDroid, rhs: SourceDroid) -> Bool {
        lhs.source == rhs.source && lhs.droid == rhs.droid
    }
}
