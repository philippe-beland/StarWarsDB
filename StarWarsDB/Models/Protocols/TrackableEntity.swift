import Foundation

protocol TrackableEntity: Entity, Observable {
    
    var nbApparitions: Int { get }
    var firstAppearance: String { get }
    var description: String { get set }
    static var htmlTag: String { get }
}
