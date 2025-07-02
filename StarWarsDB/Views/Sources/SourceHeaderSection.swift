import SwiftUI

struct SourceHeaderSection: View {
    @Binding var source: Source
    @Binding var showFactSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            HeaderView(name: $source.name, url: source.url)
            Spacer()
        }
        
        HStack {
            Button("Facts") {
                showFactSheet.toggle()
            }
            .sheet(isPresented: $showFactSheet) {
                FactsView(source: source)
            }
            Spacer()
            Toggle("Done", isOn: $source.isDone)
                .font(.callout)
                .frame(maxWidth: 110)
        }
        .padding([.horizontal])
    }
}
