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
    var infos: [String] = []
    var entities: [Entity] = []
    
    var body: some View {
        HStack {
            Text(fieldName).bold()
            Spacer()
            VStack {
                ForEach(infos, id:\.self) { info in
                    Text(info)
                }
                ForEach(entities) { entity in
                    Text(entity.name)
                }
            }
        }
        .font(.footnote)
    }
}

struct MultiFieldVStack: View {
    var fieldName: String
    var infos: [String] = []
    var entities: [Entity] = []
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .bold()
            ForEach(infos, id:\.self) { info in
                Text(info)
            }
            ForEach(entities) { entity in
                Text(entity.name)
            }
        }
    }
}

#Preview {
    FieldView(fieldName: "Name", info: "Luke Skywalker")
    FieldVStack(fieldName: "Name", info: "Luke Skywalker")
    MultiFieldView(fieldName: "Affiliation", entities: Character.example.affiliations)
    MultiFieldVStack(fieldName: "Affiliation", entities: Character.example.affiliations)
}
