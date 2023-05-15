import Foundation

public final class APIDataTransferDI {
    private var appConfiguration = AppConfiguration()
    
    public init () {}
    
    private lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.apiBaseURL)!,
            queryParameters: ["api_key": appConfiguration.apiKey]
        )
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
    
    private func handleError(with data: Data) -> APIError? {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        if let errorCode = json?["status_code"] as? Int,
           let errorMessage = json?["status_message"] as? String,
           let success = json?["success"] as? Bool {
            let apiError = APIError(
                statusCode: errorCode,
                statusMessage: errorMessage,
                success: success
            )
            return apiError
        } else {
            return nil
        }
    }
    
    public func provideApiDataTransfer() -> DataTransferService {
        return apiDataTransferService
    }
    
    public func provideErrorHandle(with data: Data) -> APIError? {
        return handleError(with: data)
    }
    
    public func provideDefaultData<T: Codable>(type: T.Type, with data: Data) -> T {
        let decoder = try! JSONDecoder().decode(type, from: data)
        return decoder
    }
    
    public func provideDefaultError() -> APIError {
        let error = APIError(
            statusCode: 0,
            statusMessage: "UnknownError",
            success: false
        )
        return error
    }
}
