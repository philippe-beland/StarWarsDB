import SwiftUI

struct ImageView: View {
    var title: String
    let baseURL = "https://pub-84c7e404f0cb414d8809fe98cb5dedff.r2.dev/"
    
    var body: some View {
        AsyncImage(url: URL(string: "\(baseURL)\(title.replacingOccurrences(of: " ", with: "_").lowercased()).jpg")) { image in
            if let image = image.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.Layout.imageViewSize , height: Constants.Layout.imageViewSize, alignment: .top)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
            } else if image.error != nil {
                Image(systemName: "xmark.circle")
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    ImageView(title: Character.example.id.uuidString)
}
