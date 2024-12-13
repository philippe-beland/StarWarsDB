//
//  EditCharacterView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import SwiftUI

struct EditCharacterView: View {
    @Bindable var character: Character
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedOption: SourceType = .movies
    
    var body: some View {
        VStack {
            Text(character.name)
                .font(.title2.bold())
                .padding()
            
            HStack {
                VStack {
                    Spacer()
                    Form {
                        Image("Luke_Skywalker")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300 , height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
                    
                    
                        Section("Infos") {
                            multiFieldView(fieldName: "Aliases", infos: character.aliases)
                            FieldView(fieldName: "Sex", info: character.sex.rawValue)
                            FieldView(fieldName: "Species", info: character.species!.name)
                            FieldView(fieldName: "Homeworld", info: character.homeworld!.name)
                            multiFieldView(fieldName: "Affiliation", infos: character.affiliation)
                            FieldView(fieldName: "First Appearance", info: character.firstAppearance ?? "")
                        }
                        Section("Comments") {
                            Text(character.comments ?? "")
                        }
                    }
                    Spacer()
                }
                .frame(width: 350)
                Spacer()
                Text("Sources")
            }
        }
    }
}

#Preview {
    EditCharacterView(character: .example)
}
