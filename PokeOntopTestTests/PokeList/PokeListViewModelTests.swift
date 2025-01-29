import XCTest
@testable import PokeOntopTest

final class PokeListViewModelTests: XCTestCase {
    
    var viewModel: PokeListViewModel!
    var repositoryMock: PokeListRepositoryMock!

    override func setUp() {
        super.setUp()
        repositoryMock = PokeListRepositoryMock()
        viewModel = PokeListViewModel(repository: repositoryMock)
        repositoryMock.output = viewModel
    }

    override func tearDown() {
        viewModel = nil
        repositoryMock = nil
        super.tearDown()
    }

    func testFetchPokemonList_Success() {
        let expectation = XCTestExpectation(description: "Fetch Pokémon List Success")
        
        let mockPokemonList = PokemonListResponse(
            count: 2,
            next: "https://pokeapi.co/api/v2/pokemon?offset=2&limit=2",
            previous: nil,
            results: [
                PokeDetail(id: 1, name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                PokeDetail(id: 2, name: "Ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
            ]
        )

        repositoryMock.mockResponse = mockPokemonList
        
        viewModel.fetchPokemonList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.pokemonList.isEmpty)
            XCTAssertEqual(self.viewModel.pokemonList.count, 2)
            XCTAssertEqual(self.viewModel.pokemonList.first?.name, "Bulbasaur")
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPokemonList_Failure() {
        let expectation = XCTestExpectation(description: "Fetch Pokémon List Failure")

        repositoryMock.shouldFail = true
        
        viewModel.fetchPokemonList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.pokemonList.isEmpty)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
