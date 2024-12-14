//
//  SourcesSection.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct SourcesSection: View {
    var sourceItems: [any SourceItem]
    var groupedEras: [Era: [any SourceItem]] {
        Dictionary(grouping: sourceItems, by: { $0.source.era })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Appearances")
                    .bold()
                    .padding()
                
                List {
                    ForEach(Era.allCases, id: \.self) { era in
                        if let items = groupedEras[era] {
                            Section(header: Text(era.rawValue)) {
                                ForEach(items, id: \.id) { sourceItem in
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
    let sourceItem: any SourceItem
    
    var body: some View {
        HStack {
            UniverseYear(year: sourceItem.source.universeYear)
                .padding(10)
            VStack (alignment: .leading) {
                Text(sourceItem.source.name)
                Text(sourceItem.source.publicationDateString)
                    .font(.caption)
            }
            .padding(10)
            
            VStack (alignment: .center) {
                Text(sourceItem.source.serie?.name ?? "")
                Text(sourceItem.source.number?.description ?? "")
            }
            .font(.callout)
            .padding(10)
            
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
    SourcesSection(sourceItems: [SourceCharacter.example])
}
