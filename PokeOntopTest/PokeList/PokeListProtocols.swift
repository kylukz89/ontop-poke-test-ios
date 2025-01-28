//
//  ListProtocols.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import Foundation

internal protocol PokeListInputProtocol: AnyObject {
    var output: PokeListOutputProtocol? { get set }
    func fetchPokemon(limit: Int, offset: Int)
}

internal protocol PokeListOutputProtocol: AnyObject {
    func fetchPokemonSuccess(response: PokemonListResponse?)
    func fetchPokemonFailure(error: Error)
}
