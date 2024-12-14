//
//  ImageView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct ImageView: View {
    var title: String = "Luke Skywalker"
    
    var body: some View {
        HStack {
            Spacer()
            Image(title.replacingOccurrences(of: " ", with: "_"))
                .resizable()
                .scaledToFill()
                .frame(width: 300 , height: 300, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
            Spacer()
        }
    }
}

#Preview {
    ImageView()
}
