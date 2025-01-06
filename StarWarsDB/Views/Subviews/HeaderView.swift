//
//  HeaderView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct HeaderView: View {
    let name: String
    let urlString: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(name)
                .font(.title.bold())
                .padding()

            Button {
                openLink()
            } label: {
                Image("Site-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }
    
    private func openLink() {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    HeaderView(name: Character.example.name, urlString: Character.example.url)
}
