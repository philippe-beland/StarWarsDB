//
//  SourceAuthor.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceAuthor: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var author: Artist
    var appearance: AppearanceType
    
    init(source: Source, author: Artist, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.author = author
        self.appearance = appearance
        
        super.init(recordType: "SourceAuthors", tableName: "source_authors", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceAuthor(source: .example, author: .example, appearance: .mentioned)
    
    static func == (lhs: SourceAuthor, rhs: SourceAuthor) -> Bool {
        lhs.source == rhs.source && lhs.author == rhs.author
    }
}
