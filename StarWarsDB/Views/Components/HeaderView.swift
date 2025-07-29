import SwiftUI

struct SectionHeaderView: View {
    @Binding var name: String
    let url: URL?
    
    var body: some View {
        HStack {
            Spacer()
            TextField("Enter Source Name", text: $name)
                .font(.title.bold())
                .padding()

            Button {
                openLink()
            } label: {
                Image("Site-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.Layout.headerIconSize, height: Constants.Layout.headerIconSize)
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }
    
    private func openLink() {
        guard let url: URL = url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    @Previewable @State var name = Character.example.name
    SectionHeaderView(name: $name, url: Character.example.url)
}
