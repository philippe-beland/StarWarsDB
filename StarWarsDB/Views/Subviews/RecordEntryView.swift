//
//  RecordEntryView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct RecordEntryView: View {
    var sourceItem: SourceItem
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: sourceItem.entity.id)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: .top)
                .clipShape(Circle())
                .foregroundStyle(.secondary)
            
            Text(sourceItem.entity.name)
                .foregroundStyle(sourceItem.number > 1 ? .primary :.secondary)
                .font(sourceItem.number > 1 ? .body : .subheadline)
            Spacer()
            AppearanceView(appearance: sourceItem.appearance.rawValue)
            
        }
    }
}
