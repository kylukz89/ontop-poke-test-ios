 
import SwiftUI

class PokeListViewModel: ObservableObject {
    
    @Published var pokemonList: [PokeDetail] = []
    @Published var isLoading = false
     
    private var repository: PokeListInputProtocol
    private var currentPage = 0
    var hasMoreData = true
    
    init(repository: PokeListInputProtocol = PokeListRepository()) {
        self.repository = repository
        self.repository.output = self
    }

    func fetchPokemonList() {
        guard !isLoading && hasMoreData else { return }
        isLoading = true
        repository.fetchPokemon(limit: Constants.itemsPerPage, offset: currentPage)
    }
}

extension PokeListViewModel: PokeListOutputProtocol {
    
    func fetchPokemonSuccess(response: PokemonListResponse?) {
        DispatchQueue.main.async {
            if let response {
                self.pokemonList.append(contentsOf: response.results)
                self.hasMoreData = response.results.count == Constants.itemsPerPage
                self.currentPage += Constants.itemsPerPage
            } else {
                self.hasMoreData = false
            }
            self.isLoading = false
        }
    }
    
    func fetchPokemonFailure(error: Error) {
        DispatchQueue.main.async { self.isLoading = false }
    }
}
