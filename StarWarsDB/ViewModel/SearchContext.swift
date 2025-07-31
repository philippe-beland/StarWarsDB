//
//  SearchContext.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2/8/25.
//

import Foundation

class SearchContext: ObservableObject {
    
    init() {
        $query
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .assign(to: &$debouncedQuery)
    }
    
    @Published var query = ""
    @Published var debouncedQuery = ""
}
