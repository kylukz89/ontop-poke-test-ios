
import XCTest
@testable import PokeOntopTest

class NetworkServiceMock: NetworkServiceProtocol {
    
    var mockResult: Result<PokemonListResponse?, Error>?

    func request<T: Decodable>(constructor: NetworkConstructor, completion: @escaping (Result<T?, Error>) -> Void) {
        guard let result = mockResult else {
            completion(.failure(NSError(domain: "MockNetworkService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock result set"])))
            return
        }

        switch result {
        case .success(let data):
            if let data = data as? T {
                completion(.success(data))
            } else {
                completion(.success(nil))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
