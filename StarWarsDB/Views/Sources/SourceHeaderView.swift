import SwiftUI

struct SourceHeaderView: View {
    @Binding var source: Source
    @Binding var showFactSheet: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.sm) {
            SectionHeaderView(name: $source.name, url: source.url)

            HStack(spacing: Constants.Spacing.md) {
                Button {
                    showFactSheet = true
                } label: {
                    Label("Facts", systemImage: "list.bullet.rectangle")
                        .font(.subheadline.weight(.medium))
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .controlSize(.small)
                .tint(.orange)
                .sheet(isPresented: $showFactSheet) {
                    SourceFactsView(source: source)
                }

                Spacer()

                Toggle(isOn: $source.isDone) {
                    Label("Done", systemImage: source.isDone ? "checkmark.circle.fill" : "circle")
                        .font(.subheadline.weight(.medium))
                        .contentTransition(.symbolEffect(.replace))
                }
                .toggleStyle(.button)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .controlSize(.small)
                .tint(source.isDone ? .green : .secondary)
            }
        }
    }
}

#Preview {
    @Previewable @State var source: Source = .example
    @Previewable @State var showFactSheet = false
    SourceHeaderView(source: $source, showFactSheet: $showFactSheet)
}
