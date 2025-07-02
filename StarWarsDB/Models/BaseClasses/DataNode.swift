import Foundation
import Supabase

/// DataNode provides the foundation for all objects that can be saved to
/// and loaded from the database. It handles basic persistence operations
/// and maintains metadata about the record type and storage location.
class DataNode: Codable {
    /// The type of record this represents (e.g., "Character", "Planet")
    let recordType: String
    let databaseTableName: String
    let recordID: UUID
    
    init(recordType: String, databaseTableName: String, recordID: UUID) {
        self.recordType = recordType
        self.databaseTableName = databaseTableName
        self.recordID = recordID
    }

    func save() {
        Task {
            do {
                try await supabase
                    .from(self.databaseTableName)
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
                    .from(self.databaseTableName)
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
                    .from(self.databaseTableName)
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
