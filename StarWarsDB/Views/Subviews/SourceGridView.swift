//
//  SourceGridView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/19/24.
//

import SwiftUI

struct SourceGridView: View {
    let source: Source
    
    var body: some View {
        ZStack {
            sourceImage
                .resizable()
                .scaledToFit()
                .frame(minWidth: 200, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 5)
            
            VStack {
                Spacer()
                sourceOverlay
            }
        }
        .padding(10)
    }
    
    private var sourceImage: Image {
        let imageName = source.id.uuidString.lowercased()
        let serieName = source.serie?.id.uuidString.lowercased() ?? ""
        
        if UIImage(named: imageName) != nil {
            return Image(imageName)
        } else if UIImage(named: serieName) != nil {
            return Image(serieName)
        } else {
            return Image(systemName: "nosign")
        }
    }
    
    private var sourceOverlay: some View {
        VStack(spacing: 2) {
            Text(source.name)
                .bold()
                .foregroundColor(.white)
            
            if let serie = source.serie, let number = source.number {
                Text("\(serie.name) #\(number)")
                    .font(.callout)
                    .foregroundStyle(Color(hue: 1.0, saturation: 0.0, brightness: 0.736))
            }
        }
        .padding(6)
        .background(Color.black.opacity(0.5))
        .cornerRadius(5)
        .padding(5)
    }
}

#Preview {
    SourceGridView(source: .example)
}
