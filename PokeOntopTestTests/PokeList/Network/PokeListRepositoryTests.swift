import XCTest
@testable import PokeOntopTest

final class PokeListRepositoryTests: XCTestCase {
    
    var sut: PokeListRepository!
    var mockNetworkService: NetworkServiceMock!
    var mockOutput: MockPokeListOutput!

    override func setUp() {
        super.setUp()
        mockNetworkService = NetworkServiceMock()
        mockOutput = MockPokeListOutput()
        sut = PokeListRepository(networkService: mockNetworkService)
        sut.output = mockOutput
    }

    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        mockOutput = nil
        super.tearDown()
    }

    func testFetchPokemon_Success() {
        let expectation = XCTestExpectation(description: "Fetch Pokémon list successfully")

        let mockPokemonList = PokemonListResponse(count: 2,
                                                  next: "next",
                                                  previous: nil,
                                                  results: [
                                                    PokeDetail(id: 1, name: "Bulbasaur", url: nil),
                                                    PokeDetail(id: 2, name: "Ivysaur", url: nil)
                                                  ])

        mockNetworkService.mockResult = .success(mockPokemonList)

        sut.fetchPokemon(limit: 2, offset: 0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.mockOutput.successResponse)
            XCTAssertEqual(self.mockOutput.successResponse?.results.count, 2)
            XCTAssertEqual(self.mockOutput.successResponse?.results.first?.name, "Bulbasaur")
            XCTAssertNil(self.mockOutput.failureError)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPokemon_Failure() {
        let expectation = XCTestExpectation(description: "Fetch Pokémon list fails")

        let mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockNetworkService.mockResult = .failure(mockError)

        sut.fetchPokemon(limit: 2, offset: 0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.mockOutput.failureError)
            XCTAssertEqual(self.mockOutput.failureError?.localizedDescription, mockError.localizedDescription)
            XCTAssertNil(self.mockOutput.successResponse)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
