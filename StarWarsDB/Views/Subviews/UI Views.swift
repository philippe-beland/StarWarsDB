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
                        .foregroundColor(.blue)
                }
                Text(entity.name)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showEntitySelection) {
            ChooseEntityView(entityType: entityType, isSourceItem: false, sourceItems: []) { selectedEntities, appearance in
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
    
    @State private var showEntitySelection: Bool = false
    
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
                        .foregroundStyle(.secondary)
                } else {
                    Text(entity.name)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showEntitySelection) {
            ChooseEntityView(entityType: entityType, isSourceItem: false, sourceItems: []) { selectedEntities, _ in
                guard let selectedEntity = selectedEntities.first else { return }
                entity = selectedEntity
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

struct PublicationDatePicker: View {
    @Binding var date: Date
    
    var body: some View {
        VStack {
            Text("Publication Date")
            DatePicker("Publication Date", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.compact)
                .labelsHidden()
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
    var source: Source?
    
    @State var artists: [SourceArtist] = []
    @State var showEditArtistSheet = false
    
    var body: some View {
        VStack {
            Button("Artists") { showEditArtistSheet.toggle() }
            ForEach(artists) { artist in
                Text(artist.entity.name)
            }
        }
        .sheet(isPresented: $showEditArtistSheet) {
            ExpandedSourceArtistsView(sourceArtists: $artists, source: source)
        }
    }
}


struct AuthorsVStack: View {
    var source: Source?
    
    @State var authors: [SourceAuthor] = []
    @State var showEditAuthorSheet = false
    
    var body: some View {
        VStack {
            Button("Authors") { showEditAuthorSheet.toggle() }
            ForEach(authors) { author in
                Text(author.entity.name)
            }
        }
        .sheet(isPresented: $showEditAuthorSheet) {
            ExpandedSourceAuthorsView(sourceAuthors: $authors, source: source)
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


struct ExpandedSourceArtistsView: View {
    @Binding var sourceArtists: [SourceArtist]
    var source: Source?
    @State var showAddArtistSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sourceArtists) { sourceItem in
                    Text(sourceItem.entity.name)
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle("Artists")
            .toolbar {
                Button("Add Artist") {
                    showAddArtistSheet.toggle()
                }
                .sheet(isPresented: $showAddArtistSheet) {
                    ChooseEntityView(entityType: .artist, isSourceItem: false, sourceItems: []) { artists, _ in
                        if let source {
                            for artist in artists {
                                let newArtist = SourceArtist(source: source, entity: artist as! Artist)
                                if !sourceArtists.contains(newArtist) {
                                    newArtist.save()
                                    sourceArtists.append(newArtist)
                                } else {
                                    print("Already exists for that source")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index: IndexSet.Element in indexSet {
            let entity = sourceArtists[index]
            sourceArtists.remove(at: index)
            entity.delete()
        }
    }
}

struct ExpandedSourceAuthorsView: View {
    @Binding var sourceAuthors: [SourceAuthor]
    var source: Source?
    @State var showAddAuthorSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sourceAuthors) { sourceItem in
                    Text(sourceItem.entity.name)
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationTitle("Authors")
            .toolbar {
                Button("Add Author") {
                    showAddAuthorSheet.toggle()
                }
                .sheet(isPresented: $showAddAuthorSheet) {
                    ChooseEntityView(entityType: .artist, isSourceItem: false, sourceItems: []) { authors, _ in
                        if let source {
                            for author in authors {
                                let newAuthor = SourceAuthor(source: source, entity: author as! Artist)
                                if !sourceAuthors.contains(newAuthor) {
                                    newAuthor.save()
                                    sourceAuthors.append(newAuthor)
                                } else {
                                    print("Already exists for that source")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index: IndexSet.Element in indexSet {
            let entity = sourceAuthors[index]
            sourceAuthors.remove(at: index)
            entity.delete()
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
