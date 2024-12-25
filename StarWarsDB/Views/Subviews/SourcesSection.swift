//
//  SourcesSection.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct SourcesSection: View {
    var sourceItems: [SourceItem]
    
    private var firstCanon: SourceItem? {
        sourceItems.min(by: { $0.source.publicationDate < $1.source.publicationDate })
    }
    
    private var groupedEras: [Era: [SourceItem]] {
        Dictionary(grouping: sourceItems, by: { $0.source.era })
    }
    
    var body: some View {
        List {
            ForEach(Era.allCases, id: \.self) { era in
                if let items = groupedEras[era] {
                    SourcesByEraView(era: era, items: items, firstCanon: firstCanon)
                }
            }
        }
    }
}

struct SourcesByEraView: View {
    let era: Era
    let items: [SourceItem]
    let firstCanon: SourceItem?
    
    var sortedItems: [SourceItem] {
        items.sorted { $0.source.publicationDate < $1.source.publicationDate }
    }
    
    var body: some View {
        Section(header: Text(era.rawValue)) {
            ForEach(sortedItems) { sourceItem in
                NavigationLink(destination: EditSourceView(source: sourceItem.source)) {
                    SourceRow(
                        sourceItem: sourceItem,
                        oldest: sourceItem.id == firstCanon?.id
                    )
                }
            }
        }
    }
}
          
struct SourceNameView: View {
    let name: String
    let serie: Serie?
    let number: Int?
    let oldest: Bool
    
    var body: some View {
        if name == "" {
            HStack (spacing: 4) {
                Text(serie?.name ?? "")
                Text(number?.description ?? "")
            }
            .font(.headline)
            .foregroundColor(oldest ? Color.red : Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        } else if serie == nil {
            Text(name)
                .font(.headline)
                .foregroundColor(oldest ? Color.red : Color.black)
                .lineLimit(1) // Ensures text doesn't overflow
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            VStack (alignment: .leading, spacing: 4) {
                
                Text(name)
                    .font(.headline)
                    .foregroundColor(oldest ? Color.red : Color.black)
                    .lineLimit(1) // Ensures text doesn't overflow
                HStack (spacing: 4) {
                    Text(serie?.name ?? "")
                    Text(number?.description ?? "")
                }
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SourceRow: View {
    let sourceItem: SourceItem
    let oldest: Bool
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: sourceItem.source.publicationDate)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            UniverseYear(year: sourceItem.source.universeYear)
                .frame(width: 50, alignment: .leading)
            
            Image(sourceItem.source.id.uuidString.lowercased())
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
            
            SourceNameView(
                name: sourceItem.source.name,
                serie: sourceItem.source.serie,
                number: sourceItem.source.number,
                oldest: oldest
                )
            
            Spacer()
            
            Text(formattedDate)
                .font(.caption)
                .foregroundColor(.secondary)

            .font(.callout)
            .multilineTextAlignment(.center)
            .frame(width: 100, alignment: .center)
            
            Spacer()

            AppearanceView(appearance: sourceItem.appearance.rawValue)
                .frame(width: 80, alignment: .center)
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
