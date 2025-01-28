//
//  PokeListViewModel.swift
//  PokeOntopTest
//
//  Created by Igor Maximo on 28/01/25.
//

import SwiftUI

class PokeDetailViewModel: ObservableObject {
    
    @Published var pokeDetail: PokeDetail?
     
    private var repository: PokeDetailInputProtocol
    
    init(repository: PokeDetailInputProtocol = PokeDetailRepository()) {
        self.repository = repository
        self.repository.output = self
    }

    func fetchPokeDetail(name: String?) {
        guard let name else { return }
        repository.fetchPokeDetail(name: name)
    }
}

extension PokeDetailViewModel: PokeDetailOutputProtocol {
    
    func fetchPokeDetailSuccess(response: PokeDetail?) {
        DispatchQueue.main.async {
            self.pokeDetail = response
        }
    }
    
    func fetchPokeDetailFailure(error: Error) {
        print(error.localizedDescription)
    }
}
