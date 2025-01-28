 
import Foundation

struct PokeDetail: Identifiable, Codable {
    let id: Int?
    let name: String
    let url: String?

    var evolutionChain: UrlObject? = nil 

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case evolutionChain = "evolution_chain"
    }
}

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}

struct PokemonResult: Identifiable, Codable {
    let id = UUID().uuidString
    let name: String
    let url: String
}

struct UrlObject: Codable {
    let url: String?
}
