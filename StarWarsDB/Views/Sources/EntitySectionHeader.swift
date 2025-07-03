import SwiftUI

struct EntitySectionHeader: View {
    let title: String
    let entityType: EntityType
    @Binding var activeSheet: ActiveSheet?
    let sourceEntities: Binding<[SourceEntity]>
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Button {
                DispatchQueue.main.async {
                    activeSheet = .entitySheet(entityType)
                }
            } label: {
                Label("Add", systemImage: "plus")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            Button {
                DispatchQueue.main.async {
                    activeSheet = .referenceSheet(entityType)
                }
            } label: {
                Text("References")
            }
            Button {
                DispatchQueue.main.async {
                    activeSheet = .expandedSheet(entityType)
                }
            } label: {
                Text("Expand")
            }
        }
    }
}
