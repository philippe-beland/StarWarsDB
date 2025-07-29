import SwiftUI

struct SourceGridView: View {
    let source: Source
    
    var body: some View {
        ZStack {
            sourceImage
            
            VStack {
                Spacer()
                sourceOverlay
            }
        }
        .padding(Constants.Spacing.sm)
    }
    
    @ViewBuilder
    private var sourceImage: some View {
        let baseURL = "https://pub-84c7e404f0cb414d8809fe98cb5dedff.r2.dev/"
        let sourceURL = URL(string: "\(baseURL)\(source.id.uuidString.lowercased()).jpg")
        let serieID = source.serie?.id.uuidString.lowercased()
        let serieURL = serieID != nil ? URL(string: "\(baseURL)\(serieID!).jpg"): nil
        
        AsyncImage(url: sourceURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: 300)
            case .success(let image):
                imageView(from: image)
            case .failure:
                // Try the serie image if available
                if let serieURL {
                    AsyncImage(url: serieURL) { seriePhase in
                        switch seriePhase {
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                        case .success(let serieImage):
                            imageView(from: serieImage)
                        case .failure:
                            fallbackImage
                        @unknown default:
                            fallbackImage
                        }
                    }
                } else {
                    fallbackImage
                }
            @unknown default:
                fallbackImage
            }
        }
    }
    
    private func imageView(from image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(minWidth: 200, maxWidth: .infinity, minHeight: 300)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 5)
    }
    
    private var fallbackImage: some View {
        Image(systemName: "nosign")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .foregroundColor(.gray)
    }
    
    private var sourceOverlay: some View {
        VStack(spacing: 2) {
            Text(source.name)
                .bold()
                .foregroundColor(.white)
            
            if let serie = source.serie, let number = source.number {
                Text("\(serie.name) #\(number)")
                    .font(.callout)
                    .foregroundStyle(Color(hue: 1.0, saturation: 0.0, brightness: 0.736))
            }
        }
        .padding(6)
        .background(Color.black.opacity(0.5))
        .cornerRadius(5)
        .padding(5)
    }
}

#Preview {
    SourceGridView(source: .example)
}
