import SwiftUI

struct SourceEntityReferenceView<T: Entity>: View {
    var url: URL?
    var sourceEntities: Binding<[SourceEntity<T>]>
    
    @State var listEntities: [String] = []
    @State var processedEntities: [WikiEntity] = []
    
    private var filteredEntities: [WikiEntity] {
        let excludedNames = Set(sourceEntities.wrappedValue.map { $0.entity.name.lowercased() })
        let x = processedEntities.filter {
            !excludedNames.contains($0.name.lowercased())
        }
        return x.sorted { $0.name < $1.name }
    }
    
    var body: some View {
        NavigationStack {
            if !filteredEntities.isEmpty {
                List {
                    ForEach(filteredEntities) { entity in
                        HStack {
                            Text(entity.name)
                                .textSelection(.enabled)
                            Spacer()
                            Text(entity.modifiers.joined(separator: ", "))
                            Spacer()
                            AppearanceView(appearance: entity.appearance.rawValue)
                                .frame(width: Constants.Layout.appearanceViewWidth, alignment: .center)
                        }
                        .textSelection(.enabled)
                    }
                }
                .navigationTitle("Missing Entries")
            } else {
                Text("All good!")
            }
        }
        .task { await fetch_list() }
    }
    
    private func fetch_list() async {
        do {
            listEntities = try await fetchInfo(entityType: T.self, for: url)
            processedEntities = processWikiEntities(listEntities)
        }
        catch {
            print("Error fetching list: \(error)")
        }
    }
}

//#Preview {
//    @Previewable var sourceEntities = SourceEntity<Planet>(source: .example, entity: .example, appearance: .present)
//    @Previewable @State var examples: [SourceEntity<Planet>] = sourceEntities.examples
//    SourceEntityReferenceView<Planet>(sourceEntities: $examples)
//}
