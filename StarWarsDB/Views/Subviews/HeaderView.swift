import SwiftUI

struct HeaderView: View {
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
                    .frame(width: 36, height: 36)
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
    HeaderView(name: $name, url: Character.example.url)
}
