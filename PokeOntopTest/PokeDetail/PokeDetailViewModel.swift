//
//  PokeListViewModel.swift
//  PokeOntopTest
//
//  Created by Igor Maximo on 28/01/25.
//

import SwiftUI

class PokeDetailViewModel: ObservableObject {
    
    @Published var pokeDetail: PokeDetail?
    @Published var pokeEvolutionDetail: PokeEvolutionDetail?
     
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

extension PokeDetailViewModel: PokeDetailOutputProtocol {
    
    func fetchPokeEvolutionDetailsSuccess(response: PokeEvolutionDetail?) {
        DispatchQueue.main.async {
            self.pokeEvolutionDetail = response
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
