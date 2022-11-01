import Foundation

public struct ListTrailerResponse: Codable {
    public let id: Int?
    public let results: [Result]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
        self.results = try container.decodeWrapper(key: .results, defaultValue: nil)
    }
    
    public struct Result: Codable {
        public let iso_639_1: String?
        public let iso_3166_1: String?
        public let name: String?
        public let key: String?
        public let published_at: String?
        public let site: String?
        public let size: Int?
        public let type: String?
        public let official: Bool?
        public let id: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.iso_639_1 = try container.decodeWrapper(key: .iso_639_1, defaultValue: "")
            self.iso_3166_1 = try container.decodeWrapper(key: .iso_3166_1, defaultValue: "")
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
            self.key = try container.decodeWrapper(key: .key, defaultValue: "")
            self.published_at = try container.decodeWrapper(key: .published_at, defaultValue: "")
            self.site = try container.decodeWrapper(key: .site, defaultValue: "")
            self.size = try container.decodeWrapper(key: .size, defaultValue: 0)
            self.type = try container.decodeWrapper(key: .type, defaultValue: "")
            self.official = try container.decodeWrapper(key: .official, defaultValue: false)
            self.id = try container.decodeWrapper(key: .id, defaultValue: "")
        }
    }
}

