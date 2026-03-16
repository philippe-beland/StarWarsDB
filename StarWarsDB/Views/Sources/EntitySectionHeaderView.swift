import SwiftUI

struct EntitySectionHeaderView<T: TrackableEntity>: View {
    let title: String
    @Binding var activeSheet: ActiveSheet?
    let sourceEntities: [SourceEntity<T>]
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var isCompact: Bool { horizontalSizeClass == .compact }

    var body: some View {
        HStack(spacing: Constants.Spacing.sm) {
            Text(title)
                .font(.headline)

            Text("\(sourceEntities.count)")
                .font(.caption.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(.blue.gradient, in: .capsule)

            Spacer()

            if isCompact {
                compactActions
            } else {
                regularActions
            }
        }
    }

    private var regularActions: some View {
        HStack(spacing: 4) {
            Button {
                activeSheet = .add(type: T.self)
            } label: {
                Image(systemName: "plus")
            }
            .tint(.green)

            Button {
                activeSheet = .referenceSheet(type: T.self)
            } label: {
                Image(systemName: "text.quote")
            }
            .tint(.orange)

            Button {
                activeSheet = .expandedSheet(type: T.self)
            } label: {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
            }
            .tint(.purple)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .controlSize(.small)
    }

    private var compactActions: some View {
        HStack(spacing: 4) {
            Button {
                activeSheet = .add(type: T.self)
            } label: {
                Image(systemName: "plus")
            }
            .tint(.green)

            Menu {
                Button {
                    activeSheet = .referenceSheet(type: T.self)
                } label: {
                    Label("References", systemImage: "text.quote")
                }
                Button {
                    activeSheet = .expandedSheet(type: T.self)
                } label: {
                    Label("Expand", systemImage: "arrow.up.left.and.arrow.down.right")
                }
            } label: {
                Image(systemName: "ellipsis")
            }
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .controlSize(.small)
    }
}

#Preview {
    @Previewable @State var activeSheet: ActiveSheet? = EditSourceViewModel(source: .example).activeSheet
    @Previewable @State var sourceEntities = [SourceEntity<Character>(source: .example, entity: .example, appearance: .present)]

    EntitySectionHeaderView<Character>(title: "Characters", activeSheet: $activeSheet, sourceEntities: sourceEntities)
}
