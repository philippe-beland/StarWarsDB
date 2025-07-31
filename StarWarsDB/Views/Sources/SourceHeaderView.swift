import SwiftUI

struct SourceHeaderView: View {
    @Binding var source: Source
    @Binding var showFactSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            SectionHeaderView(name: $source.name, url: source.url)
            Spacer()
        }
        
        HStack {
            Button("Facts") {
                showFactSheet.toggle()
            }
            .sheet(isPresented: $showFactSheet) {
                SourceFactsView(source: source)
            }
            Spacer()
            Toggle("Done", isOn: $source.isDone)
                .font(.callout)
                .frame(maxWidth: 110)
        }
        .padding(.horizontal, Constants.Spacing.md)
    }
}

#Preview {
    @Previewable @State var source: Source = .example
    @Previewable @State var showFactSheet: Bool = false
    SourceHeaderView(source: $source, showFactSheet: $showFactSheet)
}
