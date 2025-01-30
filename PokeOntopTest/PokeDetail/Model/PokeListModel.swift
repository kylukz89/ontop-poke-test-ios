 
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

struct UrlObject: Codable {
    let url: String?
}
