import Foundation

protocol TrackableEntity: Entity, Observable {
    
    var nbApparitions: Int { get }
    var firstAppearance: String { get }
    static var htmlTag: String { get }
}
