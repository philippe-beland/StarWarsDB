//
//  SourceOrganization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceOrganization: SourceItem {
    
    init(source: Source, entity: Organization, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceOrganizations", tableName: "source_organizations")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
    ]
}
