 
import Foundation

internal final class ApiConstants {
    
    static let baseURL = "https://pokeapi.co/api/v2/"
    static let imageRenderer = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    
    static func createPokemonImageURL(for id: Int) -> URL? {
        return URL(string: "\(imageRenderer)\(id).png")
    }
    
}
