//
//  NetworkService.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import Foundation

internal protocol NetworkServiceProtocol {
    func request<T: Decodable>(constructor: NetworkConstructor, completion: @escaping (Result<T?, Error>) -> Void)
}

internal class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private init() {}
    
    internal func request<T: Decodable>(constructor: NetworkConstructor, completion: @escaping (Result<T?, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: ApiConstants.baseURL) else {
            let error = NSError(domain: "InvalidBaseURL", code: ErrorCode.BAD_REQUEST.rawValue, userInfo: [NSLocalizedDescriptionKey: "Base URL is invalid"])
            completion(.failure(error))
            return
        }
        urlComponents.path = constructor.path
        
        if constructor.encoding == .urlEncoding,
           let parameters = constructor.parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: "InvalidURL", code: ErrorCode.BAD_REQUEST.rawValue, userInfo: [NSLocalizedDescriptionKey: "URL is invalid"])
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = constructor.method.rawValue
        request.allHTTPHeaderFields = constructor.headers
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.setValue("no-store", forHTTPHeaderField: "Pragma")
        
        if constructor.encoding == .json,
           let parameters = constructor.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "InvalidResponse", code: ErrorCode.INTERNAL_SERVER_ERROR.rawValue, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                completion(.failure(error))
                return
            }
            
            if httpResponse.statusCode == 204 {
                completion(.success(nil))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "NoData", code: ErrorCode.NOT_FOUND.rawValue, userInfo: [NSLocalizedDescriptionKey: "No data returned from server"])
                completion(.failure(error))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum ErrorCode: Int {
    case BAD_REQUEST = 400
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case NOT_FOUND = 404
    case METHOD_NOT_ALLOWED = 405
    case CONFLICT = 409
    case UNPROCESSABLE_ENTITY = 422
    case INTERNAL_SERVER_ERROR = 500
    case BAD_GATEWAY = 502
    case SERVICE_UNAVAILABLE = 503
    case GATEWAY_TIMEOUT = 504
    
    var description: String {
        switch self {
        case .BAD_REQUEST:
            return "Bad Request"
        case .UNAUTHORIZED:
            return "Unauthorized"
        case .FORBIDDEN:
            return "Forbidden"
        case .NOT_FOUND:
            return "Not Found"
        case .METHOD_NOT_ALLOWED:
            return "Method Not Allowed"
        case .CONFLICT:
            return "Conflict"
        case .UNPROCESSABLE_ENTITY:
            return "Unprocessable Entity"
        case .INTERNAL_SERVER_ERROR:
            return "Internal Server Error"
        case .BAD_GATEWAY:
            return "Bad Gateway"
        case .SERVICE_UNAVAILABLE:
            return "Service Unavailable"
        case .GATEWAY_TIMEOUT:
            return "Gateway Timeout"
        }
    }
}
