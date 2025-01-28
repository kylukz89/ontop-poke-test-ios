//
//  PokemonListViewModel.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import SwiftUI
import Combine

class PokeListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonResult] = []
    private var cancellables = Set<AnyCancellable>()
    private var repository: PokeListInputProtocol
    
    init(repository: PokeListInputProtocol = PokeListRepository()) {
        self.repository = repository
        
        self.repository.output = self
        
        // TODO: DELETE
//        pokemonList = [PokemonResult(name: "test", url: "sadas") ]
    }

    func fetchPokemonList() {
        repository.fetchPokemon(limit: 30, offset: 0)
    }
}

extension PokeListViewModel: PokeListOutputProtocol {
    
    func fetchPokemonSuccess(response: PokemonListResponse?) {
        DispatchQueue.main.async {
            if let response {
                self.pokemonList = response.results
            }
        }
    }
    
    func fetchPokemonFailure(error: Error) {
        print(error.localizedDescription)
    }
}
