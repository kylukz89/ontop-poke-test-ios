 
import SwiftUI

class PokeDetailViewModel: ObservableObject {
    
    @Published var pokeDetail: PokeDetail?
    @Published var pokeEvolutionDetail: PokeEvolutionDetail?
    @Published var speciesList: [PokeDetail] = []
    
    private var repository: PokeDetailInputProtocol
    
    init(repository: PokeDetailInputProtocol = PokeDetailRepository()) {
        self.repository = repository
        self.repository.output = self
    }

    func fetchPokeDetail(name: String?) {
        guard let name else { return }
        repository.fetchPokeDetail(name: name)
    }
    
    func fetchPokeEvolutionDetails(id: Int) {
        guard id >= 0 else { return }
        repository.fetchPokeEvolutionDetails(id: id)
    }
}

// MARK: - API Callbacks
extension PokeDetailViewModel: PokeDetailOutputProtocol {
    
    func fetchPokeEvolutionDetailsSuccess(response: PokeEvolutionDetail?) {
        DispatchQueue.main.async {
            self.pokeEvolutionDetail = response
            self.speciesList = self.extractPokemonNames(from: response?.chain)
        }
    }

    func fetchPokeEvolutionDetailsFailure(error: any Error) {
        print(error.localizedDescription)
    }
    
    func fetchPokeDetailSuccess(response: PokeDetail?) {
        DispatchQueue.main.async {
            self.pokeDetail = response
        }
    }
    
    func fetchPokeDetailFailure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Evolution Extraction Logic
extension PokeDetailViewModel {
    
    private func extractPokemonNames(from step: PokeEvolutionDetail.EvolutionStep?) -> [PokeDetail] {
        guard let step else { return [] }
        var speciesList: [PokeDetail] = []
        if let species = step.species {
            speciesList.append(PokeDetail(id: nil, name: species.name, url: species.url))
        }
        for evolution in step.evolvesTo ?? [] {
            speciesList.append(contentsOf: extractPokemonNames(from: evolution))
        }
        
        return speciesList
    }

    private func extractPokemonNames(from chain: PokeEvolutionDetail.EvolutionChain?) -> [PokeDetail] {
        guard let chain else { return [] }
        var speciesList: [PokeDetail] = []
        if let species = chain.species {
            speciesList.append(PokeDetail(id: nil, name: species.name, url: species.url))
        }
        for evolution in chain.evolvesTo ?? [] {
            speciesList.append(contentsOf: extractPokemonNames(from: evolution))
        }
        return speciesList
    }
}
