//
//  RecordMenuView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct RecordMenuView: View {
    var imageName: String
    var type: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                
            Text(type)
        }
    }
}

#Preview {
    RecordMenuView(imageName: "Luke_Skywalker", type: "Character")
}
