//
//  DataNode.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

enum EntityType: String, Codable {
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
}

class DataNode: Codable {
    let recordType: String
    let tableName: String
    let recordID: UUID
    
    init(recordType: String, tableName: String, recordID: UUID) {
        self.recordType = recordType
        self.tableName = tableName
        self.recordID = recordID
    }
    
    func save() {
        Task {
            do {
                try await supabase
                    .from(self.tableName)
                    .insert(self)
                    .execute()
                
                print("\(self.recordType) saved successfully")
            } catch {
                print("Failed to save \(self.recordType): \(error)")
            }
        }
    }
    
    func update() {
        Task {
            do {
                try await supabase
                    .from(self.tableName)
                    .update(self)
                    .eq("id", value: self.recordID.uuidString)
                    .execute()
                
                print("\(self.recordType) successfully updated.")
            } catch {
                print("\(self.recordType) update failed: \(error.localizedDescription)")
            }
        }
    }
    
    func delete() {
        Task {
            do {
                try await supabase
                    .from(self.tableName)
                    .delete()
                    .eq("id", value: self.recordID.uuidString)
                    .execute()
                
                print("\(self.recordType) successfully deleted.")
                
            } catch {
                print("Failed to delete \(self.recordType): \(error)")
            }
        }
    }
}

@Observable
class Entity: DataNode, Record {
    var id: UUID
    var name: String
    var comments: String
    var nbApparitions: Int
    var firstAppearance: String
    var url: String {
        "https://starwars.fandom.com/wiki/" + name.replacingOccurrences(of: " ", with: "_")
    }
    
    init(id: UUID, name: String, comments: String?, firstAppearance: String?, nbApparitions: Int = 0, recordType: String, tableName: String) {
        self.id = id
        self.name = name
        self.comments = comments ?? ""
        self.firstAppearance = firstAppearance ?? ""
        
        self.nbApparitions = nbApparitions
        
        super.init(recordType: recordType, tableName: tableName, recordID: id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

protocol Record: Identifiable, Hashable {
    var id: UUID { get }
    var name: String { get set }
    var comments: String { get set }
    var url: String { get }
}

class SourceCount: Decodable {
    var count: Int
}
