//
//  Organization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class Organization: DataNode, Record, Hashable {
    let id: UUID
    var name: String
    var comments: String
    var firstAppearance: String?
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(name: String, firstAppearance: String?, comments: String = "") {
        self.id = UUID()
        self.name = name
        self.comments = comments
        
        super.init(recordType: "Organization", tableName: "organizations", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = Organization(name: "Alphabet Squadron", firstAppearance: nil, comments: "The best squadron ever")
    
    static func == (lhs: Organization, rhs: Organization) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
