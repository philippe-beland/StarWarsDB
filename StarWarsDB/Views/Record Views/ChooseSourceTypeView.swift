//
//  ChooseSourceTypeView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/26/24.
//

import SwiftUI

struct ChooseSourceTypeView: View {
    @State private var sourceType: SourceType = .all
    @State var series: [Serie] = []
    
    var filteredSeries: [Serie] {
        series.filter({ $0.sourceType == sourceType} )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select a type", selection: $sourceType) {
                    ForEach(SourceType.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                
                switch sourceType {
                    case .all:
                    ListSourcesView(selectedView: sourceType)
                    case .movies:
                    ListSourcesView(selectedView: sourceType)
                    case .tvShow:
                    ChooseSerieView(sourceType: sourceType, series: filteredSeries)
                    case .videoGame:
                    ListSourcesView(selectedView: sourceType)
                    case .comics:
                    ChooseSerieView(sourceType: sourceType, series: filteredSeries)
                    case .novels:
                    ListSourcesView(selectedView: sourceType)
                    case .shortStory:
                    ChooseSerieView(sourceType: sourceType, series: filteredSeries)
                    case .referenceBook:
                    ListSourcesView(selectedView: sourceType)
                    }
            }
        }
        .task {
            series = await loadSeries()
        }
    }
}

struct ChooseSerieView: View {
    var sourceType: SourceType
    var series: [Serie]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(series, id: \.self) { serie in
                    NavigationLink(destination: ListSourcesView(selectedView: sourceType, serie: serie)) {
                        Text(serie.name)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ChooseSourceTypeView()
//}
