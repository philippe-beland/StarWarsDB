import SwiftUI

struct AppearanceView: View {
    let appearance: AppearanceType

    var body: some View {
        Badge(text: appearance.description, color: appearance.color)
    }

    private struct Badge: View {
        var text: String
        var color: Color

        var body: some View {
            Text(text)
                .font(.caption2)
                .fontWeight(.medium)
                .padding(.horizontal, Constants.Spacing.sm)
                .padding(.vertical, Constants.Spacing.xs)
                .background(color.opacity(0.2), in: .capsule)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    AppearanceView(appearance: .present)
}
