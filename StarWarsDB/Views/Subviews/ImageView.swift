//
//  ImageView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct ImageView: View {
    var title: String
    
    var body: some View {
        Image(title.replacingOccurrences(of: " ", with: "_"))
            .resizable()
            .scaledToFill()
            .frame(width: 300 , height: 300, alignment: .top)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
    }
}

#Preview {
    ImageView(title: "Luke Skywalker")
}
