//
//  PokemonListConstructor.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import Foundation

internal enum PokeListConstructor: NetworkConstructor {
    case getPokemon(limit: Int, offset: Int)
    
    internal var path: String {
        switch self {
        case .getPokemon:
            return "/api/v2/pokemon"
        }
    }
    
    internal var method: NetworkMethod {
        switch self {
        case .getPokemon:
            return .get
        }
    }
    
    internal var headers: NetworkHeader {
        switch self {
        case .getPokemon:
            return [:]
        }
    }
    
    internal var encoding: NetworkEncoder {
        switch self {
        case .getPokemon:
            return .urlEncoding
        }
    }
    
    internal var parameters: Parameters? {
        switch self {
        case .getPokemon(let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ]
        }
    }
}
