import SwiftUI

struct SectionHeaderView: View {
    @Binding var name: String
    let url: URL?
    @Environment(\.openURL) private var openURL

    var body: some View {
        HStack(spacing: Constants.Spacing.sm) {
            TextField("Enter Source Name", text: $name)
                .font(.title2.weight(.bold))
                .multilineTextAlignment(.leading)

            Spacer()

            if let url {
                Button {
                    openURL(url)
                } label: {
                    Image("Site-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .clipShape(.circle)
                        .overlay(Circle().strokeBorder(.quaternary, lineWidth: 1))
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    @Previewable @State var name = Character.example.name
    SectionHeaderView(name: $name, url: Character.example.url)
}
