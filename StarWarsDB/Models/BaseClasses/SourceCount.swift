/// Helper class for counting source appearances
///
/// Used when querying the database to get appearance counts for entities.
class SourceCount: Decodable {
    var count: Int
}