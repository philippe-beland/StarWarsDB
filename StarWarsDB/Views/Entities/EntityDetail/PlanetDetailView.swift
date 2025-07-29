import SwiftUI

struct PlanetInfoSection: View {
    @State var planet: Planet
    
    var body: some View {
        Section("Planet Infos") {
            RegionPicker(region: $planet.region)
            EditableTextField(fieldName: "Sector", info: $planet.sector)
            EditableTextField(fieldName: "System", info: $planet.system)
            EditableTextField(fieldName: "Capital", info: $planet.capitalCity)
//            MultiFieldView(fieldName: "Destinations", infos: $planet.destinations)
            EditableTextField(fieldName: "First Appearance", info: $planet.firstAppearance)

        }
    }
}

struct PlanetDetailView: View {
    @Bindable var planet: Planet
    @Environment(\.dismiss) var dismiss

    @State private var sourcePlanets = [SourceEntity<Planet>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $planet.name,
                    url: planet.url
                ),
                sidePanel: SidePanelView(
                    id: planet.id,
                    comments: Binding(
                        get: { planet.comments ?? "" },
                        set: { planet.comments = $0 }
                    ),
                    InfosSection: PlanetInfoSection(planet: planet)
                ),
                sourceEntities: sourcePlanets)
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
    PlanetDetailView(planet: .example)
}
