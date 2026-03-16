import SwiftUI

struct SourceEntityReferenceView<T: TrackableEntity>: View {
    var url: URL?
    var sourceEntities: [SourceEntity<T>]
        
    @State var listEntities: [String] = []
    @State var processedEntities: [WikiEntity] = []
    @State var fetchSucceeded: Bool = false
    
    /// Web entities NOT in local DB (missing from your source)
    private var missingFromLocal: [WikiEntity] {
        let localNames = Set(sourceEntities.map { $0.entity.name.lowercased() })
        return processedEntities
            .filter { !localNames.contains($0.name.lowercased()) }
            .sorted { $0.name < $1.name }
    }
    
    /// Local entities NOT on the wiki page (only valid when fetch succeeded)
    private var missingFromWeb: [SourceEntity<T>] {
        guard fetchSucceeded else { return [] }
        let webNames = Set(processedEntities.map { $0.name.lowercased() })
        return sourceEntities
            .filter { !webNames.contains($0.entity.name.lowercased()) }
            .sorted { $0.entity.name < $1.entity.name }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if missingFromLocal.isEmpty && missingFromWeb.isEmpty {
                    ContentUnavailableView("All good!", systemImage: "checkmark.circle.fill", description: Text("Local and web entries are in sync."))
                } else {
                    List {
                        if !missingFromLocal.isEmpty {
                            Section {
                                ForEach(missingFromLocal) { entity in
                                    HStack {
                                        Text(entity.name)
                                            .textSelection(.enabled)
                                        Spacer()
                                        Text(entity.modifiers.joined(separator: ", "))
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        AppearanceView(appearance: entity.appearance)
                                            .frame(width: Constants.Layout.appearanceViewWidth, alignment: .center)
                                    }
                                }
                            } header: {
                                Label("Missing from local (\(missingFromLocal.count))", systemImage: "arrow.down.circle.fill")
                                    .foregroundStyle(.orange)
                            }
                        }
                        
                        if !missingFromWeb.isEmpty {
                            Section {
                                ForEach(missingFromWeb) { sourceEntity in
                                    HStack {
                                        Text(sourceEntity.entity.name)
                                            .textSelection(.enabled)
                                        Spacer()
                                        AppearanceView(appearance: sourceEntity.appearance)
                                            .frame(width: Constants.Layout.appearanceViewWidth, alignment: .center)
                                    }
                                }
                            } header: {
                                Label("Not on Wookieepedia (\(missingFromWeb.count))", systemImage: "arrow.up.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("References")
        }
        .task { await fetch_list() }
    }
    
    private func fetch_list() async {
        do {
            listEntities = try await fetchMissingEntities(entityType: T.self, for: url)
            processedEntities = processWikiEntities(listEntities)
            fetchSucceeded = true
        }
        catch {
            appLogger.error("Error fetching list: \(error)")
            fetchSucceeded = false
        }
    }
}

#Preview {
    @Previewable var sourceEntities = [SourceEntity<Planet>(source: .example, entity: .example, appearance: .present)]
    SourceEntityReferenceView<Planet>(sourceEntities: sourceEntities)
}
