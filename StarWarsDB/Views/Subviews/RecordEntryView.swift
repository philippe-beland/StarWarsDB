//
//  RecordEntryView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct RecordEntryView: View {
    var name: String
    var imageName: UUID
    var appearance: AppearanceType
    
    var body: some View {
        HStack {
            imageOrPlaceholder(for: imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: .top)
                .clipShape(Circle())
                .foregroundStyle(.secondary)
            
            Text(name)
            Spacer()
            AppearanceView(appearance: appearance.rawValue)
            
        }
    }
}
