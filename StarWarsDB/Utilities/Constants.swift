import Foundation

enum Constants {
    enum Search {
        static let minSearchLength = 2
    }
    
    enum Spacing {
        static let xs: CGFloat = 4    // Very tight spacing (icons, badges)
        static let sm: CGFloat = 8    // Tight spacing (form elements)
        static let md: CGFloat = 16   // Standard spacing (most UI elements)
        static let lg: CGFloat = 24   // Loose spacing (sections, cards)
        static let xl: CGFloat = 32   // Very loose spacing (page sections)
    }
    
    enum CornerRadius {
        static let sm: CGFloat = 4    // Small elements (buttons, badges)
        static let md: CGFloat = 8    // Standard elements (cards, inputs)
        static let lg: CGFloat = 12   // Large elements (modals, panels)
    }
    
    enum Layout {
        static let minInfoWidth: CGFloat = 120
        static let sidePanelWidth: CGFloat = 350
        static let entityImageSize: CGFloat = 50
        static let entityRowHeight: CGFloat = 60
        static let sourceGridHeight: CGFloat = 300
        static let sourceGridMinWidth: CGFloat = 200
        static let headerIconSize: CGFloat = 36
        static let appearanceViewWidth: CGFloat = 80
        static let yearViewWidth: CGFloat = 50
        static let dateViewWidth: CGFloat = 100
        static let imageViewSize: CGFloat = 300
    }
}   
