enum EntityType: String, Codable, CaseIterable {

    case character = "Character"
    case creature = "Creature"
    case droid = "Droid"
    case organization = "Organization"
    case planet = "Planet"
    case species = "Species"
    case starshipModel = "Starship Model"
    case starship = "Starship"
    case varia = "Varia"
    case arc = "Arc"
    case serie = "Serie"
    case artist = "Artist"
    case author = "Author"
    
    var id: String { self.rawValue }
    
    var iconName: String {
            switch self {
            case .character: return "person.fill"
            case .creature: return "pawprint.fill"
            case .droid: return "gearshape.2.fill"
            case .organization: return "person.3.fill"
            case .planet: return "globe.americas.fill"
            case .species: return "leaf.fill"
            case .starshipModel: return "cube.box.fill"
            case .starship: return "airplane"
            case .varia: return "sparkles"
            case .arc: return "waveform.path.ecg"
            case .serie: return "film.fill"
            case .artist: return "paintpalette.fill"
            case .author: return "book.fill"
            }
        }

    static var sourceTypes: [EntityType] {
        [.character, .species, .planet, .organization, .starship, .starshipModel, .creature, .droid, .varia]
    }
    
    var displayName: String {
        switch self {
        case .character:
            return "Characters"
        case .creature:
            return "Creatures"
        case .droid:
            return "Droids"
        case .organization:
            return "Organizations"
        case .planet:
            return "Planets"
        case .species:
            return "Species"
        case .starship:
            return "Starships"
        case .starshipModel:
            return "Starship Models"
        case .varia:
            return "Varias"
        case .arc:
            return "Arcs"
        case .serie:
            return "Series"
        case .artist:
            return "Artists"
        case .author:
            return "Authors"
        }
    }
}