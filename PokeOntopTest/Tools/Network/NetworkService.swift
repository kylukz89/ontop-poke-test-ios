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
            let error = NSError(domain: "InvalidBaseURL", code: 400, userInfo: [NSLocalizedDescriptionKey: "Base URL is invalid"])
            completion(.failure(error))
            return
        }
        urlComponents.path = constructor.path
        
        if constructor.encoding == .urlEncoding,
           let parameters = constructor.parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: "InvalidURL", code: 400, userInfo: [NSLocalizedDescriptionKey: "URL is invalid"])
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = constructor.method.rawValue
        request.allHTTPHeaderFields = constructor.headers
        
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
                let error = NSError(domain: "InvalidResponse", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                completion(.failure(error))
                return
            }
            
            if httpResponse.statusCode == 204 {
                completion(.success(nil))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "NoData", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data returned from server"])
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
