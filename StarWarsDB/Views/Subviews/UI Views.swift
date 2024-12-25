//
//  UI Views.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import SwiftUI

struct FieldView: View {
    var fieldName: String
    var info: Binding<String>
    
    var body: some View {
        HStack {
            Text("\(fieldName):")
                .font(.footnote)
                .bold()
            TextField("Enter \(fieldName.lowercased())", text: info)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct FieldVStack: View {
    var fieldName: String
    var info: Binding<String>
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .bold()
            TextField("Info", text: info)
        }
    }
}

struct EditEntityInfoView: View {
    var fieldName: String
    @Binding var entity: Entity
    var entityType: EntityType
    
    @State private var showEntitySelection = false
    
    var body: some View {
        HStack {
            Text("\(fieldName):")
                .font(.footnote)
                .bold()
            Spacer()
            Button {
                showEntitySelection.toggle()
            } label: {
                Text(entity.name)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showEntitySelection) {
            ChooseEntityView(entityType: entityType) { selectedEntities, appearance in
                if let selectedEntity = selectedEntities.first {
                    entity = selectedEntity
                }
            }
        }
    }
}

struct GenderPicker: View {
    @Binding var gender: Gender
    
    var body: some View {
        HStack{
            Picker(selection: $gender, label: Text("Gender").font(.footnote).bold()) {
                ForEach(Gender.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
    }
}

struct RegionPicker: View {
    @Binding var region: Region
    
    var body: some View {
        HStack{
            Picker(selection: $region, label: Text("Region").font(.footnote).bold()) {
                ForEach(Region.allCases, id: \.self) {
                    Text($0.rawValue)
                        .font(.footnote)
                }
            }
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

//#Preview {
//    FieldView(fieldName: "Name", info: "Luke Skywalker")
//    FieldVStack(fieldName: "Name", info: "Luke Skywalker")
//    //MultiFieldView(fieldName: "Affiliation", entities: Character.example.affiliations)
//    //MultiFieldVStack(fieldName: "Affiliation", entities: Character.example.affiliations)
//}
