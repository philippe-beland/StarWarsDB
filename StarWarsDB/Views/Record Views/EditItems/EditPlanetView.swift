import SwiftUI

struct PlanetInfoSection: View {
    @State var planet: Planet
    
    var body: some View {
        Section("Planet Infos") {
            RegionPicker(region: $planet.region)
            FieldView(fieldName: "Sector", info: $planet.sector)
            FieldView(fieldName: "System", info: $planet.system)
            FieldView(fieldName: "Capital", info: $planet.capitalCity)
//            MultiFieldView(fieldName: "Destinations", infos: $planet.destinations)
            FieldView(fieldName: "First Appearance", info: $planet.firstAppearance)

        }
    }
}

struct EditPlanetView: View {
    @Bindable var planet: Planet
    @Environment(\.dismiss) var dismiss
    
    @State private var sourcePlanets = [SourcePlanet]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: planet, sourceItems: sourcePlanets, InfosSection: PlanetInfoSection(planet: planet))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: planet.update)
        }
        }

    
    private func loadInitialSources() async {
        sourcePlanets = await loadPlanetSources(planetID: planet.id)
    }
}

#Preview {
    EditPlanetView(planet: .example)
}
