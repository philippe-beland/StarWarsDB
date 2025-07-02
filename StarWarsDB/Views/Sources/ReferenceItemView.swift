import SwiftUI

struct ReferenceItemView: View {
    var entityType: EntityType
    var url: URL?
    var sourceItems: Binding<[SourceItem]>
    
    @State var listEntities: [String] = []
    @State var processedEntities: [WikiEntity] = []
    
    private var filteredEntities: [WikiEntity] {
        let excludedNames = Set(sourceItems.wrappedValue.map { $0.entity.name.lowercased() })
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
                                .frame(width: 80, alignment: .center)
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
            listEntities = try await fetchInfo(for: url, type: entityType)
            processedEntities = processWikiEntities(listEntities)
        }
        catch {
            print("Error fetching list: \(error)")
        }
    }
}
