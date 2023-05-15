import Foundation

public struct APIError: Codable {
    public let statusCode: Int
    public let statusMessage: String
    public let success: Bool

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
