//
//  SourceOrganization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceOrganization: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var organization: Organization
    var appearance: AppearanceType
    
    init(source: Source, organization: Organization, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.organization = organization
        self.appearance = appearance
        
        super.init(recordType: "SourceOrganizations", tableName: "source_organizations", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceOrganization(source: .example, organization: .example, appearance: .mentioned)
    
    static func == (lhs: SourceOrganization, rhs: SourceOrganization) -> Bool {
        lhs.source == rhs.source && lhs.organization == rhs.organization
    }
}
