//
//  PokemonListRepository.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import Foundation

internal class PokeListRepository: PokeListInputProtocol {
    internal var output: PokeListOutputProtocol?
    private let networkService: NetworkServiceProtocol

    internal init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchPokemon(limit: Int, offset: Int) {
        let constructor = PokeListConstructor.getPokemon(limit: limit, offset: offset)
        
        networkService.request(constructor: constructor) { (result: Result<PokemonListResponse?, Error>) in
            switch result {
            case .success(let response):
                self.output?.fetchPokemonSuccess(response: response)
            case .failure(let error):
                self.output?.fetchPokemonFailure(error: error)
            }
        }
    }
}
