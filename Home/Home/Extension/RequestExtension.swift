import Alamofire

extension Request {
    public func debugLog() -> Self {
            debugPrint("=======================================")
            debugPrint(self)
            debugPrint("=======================================")
        return self
    }
}
