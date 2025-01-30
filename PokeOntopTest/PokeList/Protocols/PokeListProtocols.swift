
import Foundation

protocol PokeListViewModelProtocol: ObservableObject {
    var pokemonList: [PokeDetail] { get set }
    var isLoading: Bool { get set }
    var hasMoreData: Bool { get set }
    func fetchPokemonList()
}

internal protocol PokeListInputProtocol: AnyObject {
    var output: PokeListOutputProtocol? { get set }
    func fetchPokemon(limit: Int, offset: Int)
}

internal protocol PokeListOutputProtocol: AnyObject {
    func fetchPokemonSuccess(response: PokemonListResponse?)
    func fetchPokemonFailure(error: Error)
}
