import Foundation

public struct GenreResponse: Codable {
    public let genres: [Genre]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = try container.decodeWrapper(key: .genres, defaultValue: nil)
    }
    
    public struct Genre: Codable {
        public let id: Int?
        public let name: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
        }
    }
}

