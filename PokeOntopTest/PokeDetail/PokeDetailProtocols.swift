 
import Foundation

internal protocol PokeDetailInputProtocol: AnyObject {
    var output: PokeDetailOutputProtocol? { get set }
    func fetchPokeDetail(name: String)
    func fetchPokeEvolutionDetails(id: Int)
}

internal protocol PokeDetailOutputProtocol: AnyObject {
    func fetchPokeDetailSuccess(response: PokeDetail?)
    func fetchPokeDetailFailure(error: Error)
    func fetchPokeEvolutionDetailsSuccess(response: PokeEvolutionDetail?)
    func fetchPokeEvolutionDetailsFailure(error: Error)
}
