import XCTest
@testable import PokeOntopTest

class PokeListViewModelMock: PokeListViewModelProtocol {
    @Published var pokemonList: [PokeDetail] = []
    @Published var isLoading = false
    @Published var hasMoreData = true
    
    func fetchPokemonList() { }
}
