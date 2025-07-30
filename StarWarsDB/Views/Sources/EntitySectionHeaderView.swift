import SwiftUI

struct EntitySectionHeaderView<T: TrackableEntity>: View {
    let title: String
    @Binding var activeSheet: ActiveSheet?
    let sourceEntities: Binding<[SourceEntity<T>]>
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Button {
                DispatchQueue.main.async {
                    activeSheet = .add(type: T.self)
                }
           } label: {
                Label("Add", systemImage: "plus")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            Button {
                DispatchQueue.main.async {
                    activeSheet = .referenceSheet(type: T.self)
                }
            } label: {
                Text("References")
            }
            Button {
                DispatchQueue.main.async {
                    activeSheet = .expandedSheet(type: T.self)
                }
            } label: {
                Text("Expand")
            }
        }
    }
}

//#Preview {
//    @Previewable @State var activeSheet: ActiveSheet? = EditSourceViewModel(source: .example).activeSheet
//    @Previewable var sourceEntities = SourceEntity<Character>(source: .example, entity: .example, appearance: .present)
//    @Previewable @State var examples: [SourceEntity<Character>] = sourceEntities.examples
//    
//    EntitySectionHeaderView<Character>(title: "Characters", activeSheet: $activeSheet, sourceEntities: $examples)
//}
