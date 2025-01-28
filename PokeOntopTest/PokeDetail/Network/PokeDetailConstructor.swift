 
import Foundation

internal enum PokeDetailConstructor: NetworkConstructor {
    
    case getPokeDetail(name: String)
    case getPokeEvolutionDetails(pokeId: Int)
    
    internal var path: String {
        switch self {
        case .getPokeDetail(let name):
            return "/api/v2/pokemon-species/\(name)"
        case .getPokeEvolutionDetails(let pokeId):
            return "/api/v2/evolution-chain/\(pokeId)/"
        }
    }
    
    internal var method: NetworkMethod {
        switch self {
        case .getPokeDetail:
            return .get
        case .getPokeEvolutionDetails:
            return .get
        }
    }
    
    internal var headers: NetworkHeader {
        switch self {
        case .getPokeDetail:
            return [:]
        case .getPokeEvolutionDetails:
            return [:]
        }
    }
    
    internal var encoding: NetworkEncoder {
        switch self {
        case .getPokeDetail:
            return .urlEncoding
        case .getPokeEvolutionDetails:
            return .urlEncoding
        }
    }
    
    internal var parameters: Parameters? {
        switch self {
        case .getPokeDetail:
            return nil
        case .getPokeEvolutionDetails:
            return nil
        }
    }
}
