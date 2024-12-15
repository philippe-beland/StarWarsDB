//
//  RecordEntryView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct RecordEntryView: View {
    var name: String
    var imageName: String
    var appearance: AppearanceType
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: .top)
                .clipShape(Circle())
            
            Text(name)
            Spacer()
            AppearanceView(appearance: appearance.rawValue)
            
        }
    }
}

#Preview {
    RecordEntryView(name: "Luke Skywalker", imageName: "Luke_Skywalker", appearance: .present)
}
