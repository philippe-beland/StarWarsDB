//
//  SourceItem.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import Foundation

protocol SourceItem: Identifiable {
    var id: UUID { get }
    var source: Source {get set}
    var appearance: AppearanceType { get set }

}
