enum EntityType: String, Codable, CaseIterable, Identifiable {

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
    
    var imageName: String {
            switch self {
            case .character: return "Luke_Skywalker"
            case .creature: return "Dianoga"
            case .droid: return "R2_astromech_droid"
            case .organization: return "Alphabet_Squadron"
            case .planet: return "Tatooine"
            case .species: return "Twi'lek"
            case .starshipModel: return "YT-1300"
            case .starship: return "Millenium_Falcon"
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
