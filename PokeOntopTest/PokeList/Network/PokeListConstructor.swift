//
//  PokemonListConstructor.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import Foundation

internal enum PokeListConstructor: NetworkConstructor {
    case getPokemonSpecies(limit: Int, offset: Int)
    
    internal var path: String {
        switch self {
        case .getPokemonSpecies:
            return "/api/v2/pokemon-species"
        }
    }
    
    internal var method: NetworkMethod {
        switch self {
        case .getPokemonSpecies:
            return .get
        }
    }
    
    internal var headers: NetworkHeader {
        switch self {
        case .getPokemonSpecies:
            return [:]
        }
    }
    
    internal var encoding: NetworkEncoder {
        switch self {
        case .getPokemonSpecies:
            return .urlEncoding
        }
    }
    
    internal var parameters: Parameters? {
        switch self {
        case .getPokemonSpecies(let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ]
        }
    }
}
