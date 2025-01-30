import XCTest
@testable import PokeOntopTest

class MockPokeListOutput: PokeListOutputProtocol {
    var successResponse: PokemonListResponse?
    var failureError: Error?
    
    func fetchPokemonSuccess(response: PokemonListResponse?) {
        successResponse = response
    }
    
    func fetchPokemonFailure(error: Error) {
        failureError = error
    }
}
