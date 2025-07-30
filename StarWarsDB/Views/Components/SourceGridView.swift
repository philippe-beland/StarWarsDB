import SwiftUI

struct SourceGridView: View {
    let source: Source
    
    var body: some View {
        ZStack {
            CDNImageView(
                primaryID: source.id,
                fallbackID: source.serie?.id
            )
            .frame(minWidth: 200, maxWidth: .infinity, minHeight: 300)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 5)
            
            VStack {
                Spacer()
                sourceOverlay
            }
        }
        .padding(Constants.Spacing.sm)
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
