import Foundation
import Components

public struct ListReviewsResponse: Codable {
    public let id: Int?
    public let page: Int?
    public let results: [Result]?
    public let total_pages: Int?
    public let total_results: Int?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
        self.page = try container.decodeWrapper(key: .page, defaultValue: 0)
        self.results = try container.decodeWrapper(key: .results, defaultValue: nil)
        self.total_pages = try container.decodeWrapper(key: .total_pages, defaultValue: 0)
        self.total_results = try container.decodeWrapper(key: .total_results, defaultValue: 0)
    }
    
    public struct Result: Codable {
        public let author: String?
        public let author_details: AuthorDetails?
        public let content: String?
        public let created_at: String?
        public let id: String?
        public let updated_at: String?
        public let url: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.author = try container.decodeWrapper(key: .author, defaultValue: "")
            self.author_details = try container.decodeWrapper(key: .author_details, defaultValue: nil)
            self.content = try container.decodeWrapper(key: .content, defaultValue: "")
            self.created_at = try container.decodeWrapper(key: .created_at, defaultValue: "")
            self.id = try container.decodeWrapper(key: .id, defaultValue: "")
            self.updated_at = try container.decodeWrapper(key: .updated_at, defaultValue: "")
            self.url = try container.decodeWrapper(key: .url, defaultValue: "")
        }
        
        public struct AuthorDetails: Codable {
            public let name: String?
            public let username: String?
            public let avatar_path: String?
            public let rating: Int?
            
            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.name = try container.decodeWrapper(key: .name, defaultValue: "")
                self.username = try container.decodeWrapper(key: .username, defaultValue: "")
                self.avatar_path = try container.decodeWrapper(key: .avatar_path, defaultValue: "")
                self.rating = try container.decodeWrapper(key: .rating, defaultValue: 0)
            }
        }
    }
}
