import SwiftUI
import Kingfisher

struct CDNImageView: View {
    let primaryID: UUID
    var fallbackID: UUID? = nil

    private let baseURL = "https://pub-84c7e404f0cb414d8809fe98cb5dedff.r2.dev/"
    @State private var useFallback = false
    @State private var hasError = false

    private var primaryURL: URL? {
        URL(string: "\(baseURL)\(primaryID.uuidString.lowercased()).jpg")
    }

    private var fallbackURL: URL? {
        guard let fallbackID else { return nil }
        return URL(string: "\(baseURL)\(fallbackID.uuidString.lowercased()).jpg")
    }

    var body: some View {
        if hasError {
            fallbackImage
        } else {
            KFImage(useFallback ? fallbackURL : primaryURL)
                .onFailure { _ in
                    if !useFallback, fallbackURL != nil {
                        useFallback = true
                    } else {
                        hasError = true
                    }
                }
                .placeholder {
                    ProgressView()
                }
                .cancelOnDisappear(true)
                .resizable()
                .scaledToFill()
        }
    }

    private var fallbackImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }
}

#Preview {
    CDNImageView(primaryID: Character.example.id)
}
