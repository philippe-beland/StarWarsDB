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
                if entity.name.isEmpty {
                    Text("Select \(fieldName)")
                        .foregroundStyle(.secondary)
                }
                Text(entity.name)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showEntitySelection) {
            ChooseEntityView(entityType: entityType, isSourceItem: false) { selectedEntities, appearance in
                if let selectedEntity = selectedEntities.first {
                    entity = selectedEntity
                }
            }
        }
    }
}

struct EditVEntityInfoView: View {
    var fieldName: String
    @Binding var entity: Entity
    var entityType: EntityType
    
    @State private var showEntitySelection = false
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .font(.footnote)
                .bold()
            Button {
                showEntitySelection.toggle()
            } label: {
                if entity.name.isEmpty {
                    Text("Select \(fieldName)")
                        .foregroundColor(.blue)
                }
                Text(entity.name)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showEntitySelection) {
            ChooseEntityView(entityType: entityType, isSourceItem: false) { selectedEntities, appearance in
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

struct YearPicker: View {
    let era: Era
    @Binding var universeYear: Float
    var yearString: String {
        "\(abs(Int(universeYear))) \(universeYear > 0 ? "ABY" : "BBY")"
    }
    
    var body: some View {
        VStack {
            Text("In-Universe Year")
            Slider(value: $universeYear,
                   in: era.minimum...era.maximum,
                   step: 1,
                   minimumValueLabel: Text("\(Int(era.minimum))"),
                   maximumValueLabel: Text("\(Int(era.maximum))"),
                   label: {
                Text(yearString).font(.footnote).bold()
            }
            )
            Text(yearString).font(.footnote).bold()
        }
    }
}

struct EraPicker: View {
    @Binding var era: Era
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Era")
            Picker(selection: $era, label: Text("Era").font(.footnote).bold()) {
                ForEach(Era.allCases, id: \.self) {
                    Text($0.rawValue)
                        .font(.footnote)
                }
            }
        }
    }
}

struct SourceTypePicker: View {
    @Binding var sourceType: SourceType
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Source Type")
            Picker(selection: $sourceType, label: Text("Source Type").font(.footnote).bold()) {
                ForEach(SourceType.allCases, id: \.self) {
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

struct ArtistsVStack: View {
    var fieldName: String
    @State var entities: [SourceItem] = []
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .bold()
            ForEach(entities) { entity in
                Text(entity.entity.name)
            }
        }
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
    @Previewable @State var era = Source.example.era
    @Previewable @State var year = Source.example.universeYear
    @Previewable @State var fieldName = "Luke Skywalker"
    
    YearPicker(era: era, universeYear: $year)
    FieldView(fieldName: "Name", info: $fieldName)
    FieldVStack(fieldName: "Name", info: $fieldName)
    //MultiFieldView(fieldName: "Affiliation", entities: Character.example.affiliations)
    //MultiFieldVStack(fieldName: "Affiliation", entities: Character.example.affiliations)
}
