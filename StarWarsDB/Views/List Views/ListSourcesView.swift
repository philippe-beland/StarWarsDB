//
//  ListSourcesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/18/24.
//

import SwiftUI

struct ListSourcesView: View {
    @State private var sortOrder: SortingSourceOrder = .publicationDate
    @State private var selectedView: SourceType = .movies
    @State private var searchText: String = ""
    @State private var isDoneFilter: Bool = false
    @State private var showNewSourceSheet = false
    @State private var sources: [Source] = []
    
    let layout = [GridItem(.adaptive(minimum: 200, maximum: 300)),]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(sources) { source in
                        SourceNavigationLink(source: source)
                            .contextMenu { SourceContextMenu(source: source) }
                    }
                }
            }
            .navigationTitle("Sources")
            .searchable(text: $searchText, prompt: "Search")
            .toolbar { toolbarContent }
        }
        .onChange(of: searchText) { handleSearchTextChange() }
        .onChange(of: selectedView) { handleParameterChange() }
        .onChange(of: sortOrder) { handleParameterChange() }
        .onChange(of: isDoneFilter) { handleParameterChange() }
        .task { await loadInitialSources() }
    }
    
    private func handleParameterChange() {
        Task {
            sources = await loadSources(sort: sortOrder.rawValue, sourceType: selectedView, isDone: isDoneFilter, filter: searchText)
        }
    }
    
    private func handleSearchTextChange() {
        Task {
            if !searchText.isEmpty && searchText.count > 3 {
                sources = await loadSources(sort: sortOrder.rawValue, sourceType: selectedView, isDone: isDoneFilter, filter: searchText)
            }
        }
    }
    
    private func loadInitialSources() async {
        sources = await loadSources(sort: sortOrder.rawValue, sourceType: selectedView, isDone: isDoneFilter, filter: searchText)
    }
    
    private func deleteSource(_ source: Source) {
        if let index = sources.firstIndex(of: source) {
            sources.remove(at: index)
        }
        source.delete()
    }
    
    @ViewBuilder
    private func SourceNavigationLink(source: Source) -> some View {
        NavigationLink(destination: EditSourceView(source: source)) {
            SourceGridView(source: source)
        }
    }

    @ViewBuilder
    func SourceContextMenu(source: Source) -> some View {
        Button("Delete", role: .destructive, action: { deleteSource(source) })
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button ("Create") {
                showNewSourceSheet.toggle()
            }
            .sheet(isPresented: $showNewSourceSheet) {
                AddSourceView { source in
                    sources.append(source)}
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("Sort", selection: $sortOrder) {
                    Text("Publication Date").tag(SortingSourceOrder.publicationDate)
                    Text("Universe Year").tag(SortingSourceOrder.universeYear)
                }
            }
        }
        
        ToolbarItem(placement: .topBarLeading) {
            Menu("Source Type") {
                ForEach(SourceType.allCases, id: \.self) { sourceType in
                    Button(sourceType.rawValue) {
                        selectedView = sourceType
                    }
                }
            }
        }
        
        ToolbarItem(placement: .topBarLeading) {
            Toggle("ToDo", isOn: $isDoneFilter)
                .toggleStyle(ButtonToggleStyle())
        }
    }
}

#Preview {
    ListSourcesView()
}
