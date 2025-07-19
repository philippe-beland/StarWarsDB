import SwiftUI

struct AddPlanetView: View, AddEntityView {
    typealias EntityType = Planet
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var region: Region = .unknown
    @State private var sector: String = ""
    @State private var system: String = ""
    @State private var capitalCity: String = ""
    @State private var destinations: [String] = []
    @State private var firstAppearance: String = ""
    @State private var comments: String = ""
    
    var onAdd: (Planet) -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                Form {
                    Section("Planet Infos") {
                        RegionPicker(region: $region)
                        FieldView(fieldName: "Sector", info: $sector)
                        FieldView(fieldName: "System", info: $system)
                        FieldView(fieldName: "Capital", info: $capitalCity)
            //            MultiFieldView(fieldName: "Destinations", infos: $planet.destinations)
                        FieldView(fieldName: "First Appearance", info: $firstAppearance)
                    }
                    CommentsView(comments: $comments)
                    
                    Section {
                        Button("Save", action: savePlanet)
                            .disabled(name.isEmpty)
                    }
                }
            }
        }
        .navigationTitle("Add new Planet")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func savePlanet() {
        let newPlanet = Planet(name: name, region: region, sector: sector, system: system, capitalCity: capitalCity, destinations: destinations, firstAppearance: firstAppearance, comments: comments)
        newPlanet.save()
        onAdd(newPlanet)
        dismiss()
    }
}

#Preview {
    AddPlanetView(onAdd: { _ in })
}
