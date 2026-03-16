import SwiftUI

// MARK: - ActiveSheet

enum ActiveSheet: Identifiable {
    case add(type: any Entity.Type)
    case referenceSheet(type: any Entity.Type)
    case expandedSheet(type: any Entity.Type)

    var id: String {
        switch self {
        case .add(let type):
            "add-\(type)"
        case .referenceSheet(let type):
            "reference-\(type)"
        case .expandedSheet(let type):
            "expanded-\(type)"
        }
    }
}

// MARK: - Main View

struct SourceDetailView: View {
    @Bindable var viewModel: EditSourceViewModel
    @State private var showFactSheet = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var isCompact: Bool { horizontalSizeClass == .compact }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SourceHeaderView(source: $viewModel.source, showFactSheet: $showFactSheet)
                    .padding(.horizontal, Constants.Spacing.md)
                    .padding(.vertical, Constants.Spacing.sm)

                metadataSection

                SourceAppearancesSection(
                    viewModel: viewModel,
                    serie: viewModel.source.serie,
                    url: viewModel.source.url,
                    onAddEntity: viewModel.addAnyEntity
                )
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
        }
        .task { await viewModel.loadInitialSources() }
        .toolbar {
            Button {
                Task { await viewModel.source.update() }
            } label: {
                Text("Save")
                    .fontWeight(.semibold)
            }
        }
    }

    // MARK: - Metadata Section

    private var gridColumns: [GridItem] {
        if isCompact {
            return [GridItem(.flexible())]
        } else {
            return [GridItem(.adaptive(minimum: 160, maximum: 300), spacing: Constants.Spacing.sm)]
        }
    }

    private var metadataSection: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, alignment: .leading, spacing: Constants.Spacing.sm) {
                MetadataField("Serie", systemImage: "film.stack", color: .blue) {
                    EditableLinkedBaseEntity(
                        baseEntity: Binding(
                            get: { viewModel.source.serie ?? Serie.empty },
                            set: { viewModel.source.serie = $0 }
                        )
                    ) {
                        Text(viewModel.source.serie?.name ?? "Select Serie")
                            .foregroundStyle(.tint)
                    }
                }

                MetadataField("Arc", systemImage: "arrow.triangle.branch", color: .indigo) {
                    EditableLinkedBaseEntity(
                        baseEntity: Binding(
                            get: { viewModel.source.arc ?? Arc.empty },
                            set: { viewModel.source.arc = $0 }
                        )
                    ) {
                        Text(viewModel.source.arc?.name ?? "Select Arc")
                            .foregroundStyle(.tint)
                    }
                }

                MetadataField("Number", systemImage: "number", color: .orange) {
                    TextField("—", value: $viewModel.source.number, format: .number)
                }

                MetadataField("Era", systemImage: "clock.arrow.circlepath", color: .purple) {
                    EraPicker(era: $viewModel.source.era)
                }

                MetadataField("Type", systemImage: "tag", color: .teal) {
                    SourceTypePicker(sourceType: $viewModel.source.sourceType)
                }

                MetadataField("Publication Date", systemImage: "calendar", color: .red) {
                    PublicationDatePicker(date: $viewModel.source.publicationDate)
                }

                MetadataField("In-Universe Year", systemImage: "sparkles", color: .yellow) {
                    YearPicker(era: viewModel.source.era, universeYear: $viewModel.source.universeYear)
                }

                MetadataField("Pages", systemImage: "doc.plaintext", color: .gray) {
                    TextField("—", value: $viewModel.source.numberPages, format: .number)
                }

                MetadataField("Authors", systemImage: "pencil.line", color: .mint) {
                    AuthorsVStack(source: viewModel.source, sourceAuthors: $viewModel.authors)
                }

                MetadataField("Artists", systemImage: "paintbrush", color: .pink) {
                    ArtistsVStack(source: viewModel.source, sourceArtists: $viewModel.artists)
                }
            }
            .padding(Constants.Spacing.md)
        }
        .scrollIndicators(isCompact ? .visible : .hidden)
        .frame(maxHeight: isCompact ? 200 : 260)
    }
}

// MARK: - MetadataField

private struct MetadataField<Content: View>: View {
    let title: String
    let systemImage: String
    let iconColor: Color
    @ViewBuilder let content: Content
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    init(_ title: String, systemImage: String, color: Color = .accentColor, @ViewBuilder content: () -> Content) {
        self.title = title
        self.systemImage = systemImage
        self.iconColor = color
        self.content = content()
    }

    private var isCompact: Bool { horizontalSizeClass == .compact }

    private var iconLabel: some View {
        HStack(spacing: 5) {
            Image(systemName: systemImage)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 18, height: 18)
                .background(iconColor.gradient, in: .rect(cornerRadius: 4))

            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .textCase(.uppercase)
                .tracking(0.5)
                .foregroundStyle(.secondary)
        }
    }

    var body: some View {
        Group {
            if isCompact {
                HStack {
                    iconLabel
                    Spacer()
                    content
                        .font(.subheadline)
                        .multilineTextAlignment(.trailing)
                }
            } else {
                VStack(alignment: .leading, spacing: 6) {
                    iconLabel
                    content
                        .font(.subheadline)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 8 : 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: .rect(cornerRadius: Constants.CornerRadius.lg))
        .shadow(color: .black.opacity(0.04), radius: 2, y: 1)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var viewModel = EditSourceViewModel(source: .example)
    SourceDetailView(viewModel: viewModel)
}
