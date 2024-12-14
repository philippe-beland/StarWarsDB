//
//  SourcesSection.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct SourcesSection: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...10, id: \.self) {
                    Text(String($0))
                }
            }
            .navigationTitle("Appearances")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SourcesSection()
}
