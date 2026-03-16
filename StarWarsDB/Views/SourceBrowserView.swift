import SwiftUI

struct SourceBrowserView: View {
    @State private var selectedSourceType: SourceType?
    @State private var availableSeries: [Serie] = []

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select a type", selection: $selectedSourceType) {
                    Text("All").tag(nil as SourceType?)
                    ForEach(SourceType.allCases, id: \.self) { sourceType in
                        Text(sourceType.rawValue).tag(sourceType as SourceType?)
                    }
                }
                .pickerStyle(.segmented)

                if let selectedType = selectedSourceType,
                   selectedType == .tvShow || selectedType == .comics || selectedType == .shortStory {
                    SerieListBrowserView(
                        sourceType: selectedType,
                        series: filteredSeries(for: selectedType)
                    )
                } else {
                    SourceListBrowserView(selectedType: selectedSourceType)
                }
            }
            .navigationTitle("Sources")
        }
        .task {
            availableSeries = await loadSeries()
        }
    }

    private func filteredSeries(for sourceType: SourceType) -> [Serie] {
        var filtered = availableSeries.filter { $0.sourceType == sourceType }
        let allOption = Serie(name: "All", sourceType: sourceType, comments: "")
        filtered.insert(allOption, at: 0)
        return filtered
    }
}

#Preview {
    SourceBrowserView()
}
