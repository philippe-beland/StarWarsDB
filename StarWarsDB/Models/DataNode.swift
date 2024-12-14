//
//  DataNode.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

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

protocol Record: Identifiable {
    var id: UUID { get }
    var name: String { get set }
    var comments: String { get set }
    var url: String { get }
}
