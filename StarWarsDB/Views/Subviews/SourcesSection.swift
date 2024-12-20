//
//  SourcesSection.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct SourcesSection: View {
    var sourceItems: [SourceItem]
    private var groupedEras: [Era: [SourceItem]] {
        Dictionary(grouping: sourceItems, by: { $0.source.era })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Era.allCases, id: \.self) { era in
                    if let items = groupedEras[era] {
                        Section(header: Text(era.rawValue)) {
                            ForEach(items) { sourceItem in
                                NavigationLink(destination: EditSourceView(source: sourceItem.source)) {
                                    SourceList(sourceItem: sourceItem)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
                                        
struct SourceList: View {
    let sourceItem: SourceItem
    
    var body: some View {
        HStack(spacing: 20) {
            UniverseYear(year: sourceItem.source.universeYear)
            VStack (alignment: .leading) {
                Text(sourceItem.source.name)
                    .font(.headline)
                Text(sourceItem.source.publicationDateString)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            VStack (alignment: .center, spacing: 4) {
                Text(sourceItem.source.serie?.name ?? "")
                Text(sourceItem.source.number?.description ?? "")
                    .foregroundColor(.secondary)
            }
            .font(.callout)
            .multilineTextAlignment(.center)
            
            Spacer()

            AppearanceView(appearance: sourceItem.appearance.rawValue)
        }
    }
}

struct UniverseYear: View {
    let year: Int?
    
    var body: some View {
        VStack {
            if let year {
                Text("\(abs(year))")
                Text(year > 0 ? "ABY" : "BBY")
            } else {
                Text("")
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}

#Preview {
    SourcesSection(sourceItems: SourceCharacter.example)
}
