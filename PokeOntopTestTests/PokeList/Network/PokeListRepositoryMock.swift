import XCTest
@testable import PokeOntopTest

class PokeListRepositoryMock: PokeListInputProtocol {
    var output: PokeListOutputProtocol?
    var mockResponse: PokemonListResponse?
    var shouldFail = false
    
    func fetchPokemon(limit: Int, offset: Int) {
        if shouldFail {
            output?.fetchPokemonFailure(error: NSError(domain: "TestError", code: 1, userInfo: nil))
        } else {
            output?.fetchPokemonSuccess(response: mockResponse)
        }
    }
}
