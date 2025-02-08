//
//  ListSerieView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 1/10/25.
//

import SwiftUI

struct ListSerieView: View {
    var sourceType: SourceType
    var series: [Serie]
    
    @State private var searchText: String = ""
    
    private var filteredSeries: [Serie] {
        series.filter {
            if searchText != "" {
                return $0.name.localizedStandardContains(searchText)
            } else {
                return true
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                List(filteredSeries) { serie in
                    NavigationLink(destination: ListSourcesView(selectedView: sourceType, serie: serie)) {
                        Text(serie.name)
                    }
                }
            }
        }
    }
}

#Preview {
    let mockSeries = [
        Serie(name: "Darth Vader(2020)", sourceType: .comics, comments: ""),
        Serie(name: "Age of Rebellion", sourceType: .comics, comments: "")
    ]
    ListSerieView(sourceType: .comics, series: mockSeries)
}
