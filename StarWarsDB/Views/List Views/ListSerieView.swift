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
    
    var body: some View {
        NavigationStack {
            List(series, id: \.self) { serie in
                NavigationLink(destination: ListSourcesView(selectedView: sourceType, serie: serie)) {
                    Text(serie.name)
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
