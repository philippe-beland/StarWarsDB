//
//  SourcesSection.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct SourcesSection: View {
    var sources: [SourceCharacter]
    var groupedEras: [Era: [SourceCharacter]] {
        Dictionary(grouping: sources, by: { $0.source.era })
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
                                ForEach(items) { sourceCharacter in
                                    SourceList(sourceCharacter: sourceCharacter)
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
    let sourceCharacter: SourceCharacter
    
    var body: some View {
        HStack {
            UniverseYear(year: sourceCharacter.source.universeYear)
                .padding(10)
            VStack (alignment: .leading) {
                Text(sourceCharacter.source.name)
                Text(sourceCharacter.source.publicationDateString)
                    .font(.caption)
            }
            .padding(10)
            
            VStack (alignment: .center) {
                Text(sourceCharacter.source.serie?.name ?? "")
                Text(sourceCharacter.source.number?.description ?? "")
            }
            .font(.callout)
            .padding(10)
            
            Spacer()

            AppearanceView(appearance: sourceCharacter.appearance.rawValue)
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
    SourcesSection(sources: [.example])
}
