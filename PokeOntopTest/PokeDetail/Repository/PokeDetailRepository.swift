 
import Foundation

internal class PokeDetailRepository: PokeDetailInputProtocol {
    
    internal var output: PokeDetailOutputProtocol?
    private let networkService: NetworkServiceProtocol

    internal init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchPokeDetail(name: String) {
        let constructor = PokeDetailConstructor.getPokeDetail(name: name)
        networkService.request(constructor: constructor) { (result: Result<PokeDetail?, Error>) in
            switch result {
            case .success(let response):
                self.output?.fetchPokeDetailSuccess(response: response)
            case .failure(let error):
                self.output?.fetchPokeDetailFailure(error: error)
            }
        }
    }
    
    func fetchPokeEvolutionDetails(id: Int) {
        let constructor = PokeDetailConstructor.getPokeEvolutionDetails(pokeId: id)
        networkService.request(constructor: constructor) { (result: Result<PokeEvolutionDetail?, Error>) in
            switch result {
            case .success(let response):
                self.output?.fetchPokeEvolutionDetailsSuccess(response: response)
            case .failure(let error):
                self.output?.fetchPokeEvolutionDetailsFailure(error: error)
            }
        }
    }
}
