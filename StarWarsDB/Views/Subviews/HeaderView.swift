//
//  HeaderView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct HeaderView: View {
    @Binding var name: String
    let url: URL?
    
    var body: some View {
        HStack {
            Spacer()
            TextField("Enter Source Name", text: $name)
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
        guard let url: URL = url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

//#Preview {
//    HeaderView(name: Character.example.name, urlString: Character.example.url)
//}
