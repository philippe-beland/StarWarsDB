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

struct FieldVStack: View {
    var fieldName: String
    var info: String
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .bold()
            Text(info)
        }
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

struct MultiFieldVStack: View {
    var fieldName: String
    var infos: [any Record]
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .bold()
            ForEach(infos, id: \.id) { info in
                Text(info.name)
            }
        }
    }
}

#Preview {
    FieldView(fieldName: "Name", info: "Luke Skywalker")
    FieldVStack(fieldName: "Name", info: "Luke Skywalker")
    MultiFieldView(fieldName: "Affiliation", infos: Character.example.affiliations)
    MultiFieldVStack(fieldName: "Affiliation", infos: Character.example.affiliations)
}
