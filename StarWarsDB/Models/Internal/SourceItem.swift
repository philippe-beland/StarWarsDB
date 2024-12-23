//
//  SourceItem.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import Foundation

class SourceItem: DataNode, Equatable, Identifiable {
    var id: UUID
    var source: Source
    var entity: Entity
    var appearance: AppearanceType
    
    init (id: UUID, source: Source, entity: Entity, appearance: AppearanceType, recordType: String, tableName: String) {
        self.id = id
        self.source = source
        self.entity = entity
        self.appearance = appearance
        
        super.init(recordType: recordType, tableName: tableName, recordID: self.id)
    }
                   
    required init(from decoder: Decoder) throws {
       fatalError("init(from:) has not been implemented")
    }

    static func == (lhs: SourceItem, rhs: SourceItem) -> Bool {
       lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
