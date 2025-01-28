//
//  PokeDetailConstructor.swift
//  PokeOntopTest
//
//  Created by Igor Maximo on 28/01/25.
//


import Foundation

internal enum PokeDetailConstructor: NetworkConstructor {
    case getPokeDetail(name: String)
    
    internal var path: String {
        switch self {
        case .getPokeDetail(let name):
            return "/api/v2/pokemon-species/\(name)"
        }
    }
    
    internal var method: NetworkMethod {
        switch self {
        case .getPokeDetail:
            return .get
        }
    }
    
    internal var headers: NetworkHeader {
        switch self {
        case .getPokeDetail:
            return [:]
        }
    }
    
    internal var encoding: NetworkEncoder {
        switch self {
        case .getPokeDetail:
            return .urlEncoding
        }
    }
    
    internal var parameters: Parameters? {
        switch self {
        case .getPokeDetail:
            return nil
        }
    }
}
