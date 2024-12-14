//
//  UI Views.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import SwiftUI

struct FieldView: View {
    var fieldName: String
    var info: String
    
    var body: some View {
        HStack {
            Text("\(fieldName):")
                .bold()
            Spacer()
            Text(info)
        }
        .font(.footnote)
    }
}

struct MultiFieldView: View {
    var fieldName: String
    var infos: [any Record]
    
    var body: some View {
        HStack {
            Text(fieldName).bold()
            Spacer()
            VStack {
                ForEach(infos, id: \.id) { info in
                    Text(info.name)
                }
            }
        }
        .font(.footnote)
    }
}

#Preview {
    //FieldView(fieldName: "Name", info: "Luke Skywalker")
    MultiFieldView(fieldName: "Affiliation", infos: Character.example.affiliation)
}
