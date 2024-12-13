//
//  DataNode.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

class DataNode: Codable, Identifiable, Observable {
    let recordType: String
    let tableName: String
    let recordID: String
    
    init(recordType: String, tableName: String, recordID: String) {
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
                    .eq("id", value: self.recordID)
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
                    .eq("id", value: self.recordID)
                    .execute()
                
                print("\(self.recordType) successfully deleted.")
                
            } catch {
                print("Failed to delete \(self.recordType): \(error)")
            }
        }
    }
}

protocol Record: Identifiable {
    var id: String { get }
    var name: String { get set }
}
