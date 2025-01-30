 
import Foundation

internal typealias Parameters = [String: Any]
internal typealias NetworkHeader = [String: String]

internal struct NetworkMethod: RawRepresentable, Equatable, Hashable {

    public static let get = NetworkMethod(rawValue: "GET")
    public static let post = NetworkMethod(rawValue: "POST")
    public static let put = NetworkMethod(rawValue: "PUT")
    public static let delete = NetworkMethod(rawValue: "DELETE")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

internal enum NetworkEncoder {
    case json
    case urlEncoding
}

internal protocol NetworkConstructor {
    
    var path: String {get}
    
    var method: NetworkMethod {get}
    
    var headers: NetworkHeader {get}
    
    var encoding: NetworkEncoder {get}
    
    var parameters: Parameters? {get}
}
