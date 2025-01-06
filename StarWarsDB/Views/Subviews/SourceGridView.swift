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
                .clipped()
                .clipShape(.rect(cornerRadius: 15))
                .shadow(radius: 5)
            
            VStack {
                Spacer()
                if let serie = source.serie, let number = source.number {
                    VStack {
                        Text(source.name)
                            .bold()
                            .foregroundColor(.white)
                        Text("\(serie.name) #\(number)")
                            .font(.callout)
                            .foregroundStyle(Color(hue: 1.0, saturation: 0.0, brightness: 0.736))
                    }
                    .padding(3)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(5)
                    .padding(5)
                } else {
                    Text(source.name)
                        .bold()
                        .foregroundColor(.white)
                        .padding(3)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(5)
                        .padding(5)
                }
            }
        }
        .padding(10)
    }
    
    private var sourceImage: Image {
        let imageName = source.id.uuidString.lowercased()
        let serieName = source.serie?.name ?? ""
        if UIImage(named: imageName) != nil {
            return Image(imageName)
        } else if UIImage(named: serieName) != nil {
            return Image(serieName)
        } else {
            return Image(systemName: "nosign")
        }
    }
}

#Preview {
    SourceGridView(source: .example)
}
