//
//  PokemonDetailView.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import SwiftUI

struct PokeDetailView: View {
    
    @StateObject private var viewModel = PokeDetailViewModel()
    
    let pokeName: String

    var body: some View {
        VStack(spacing: 20) {
            if let pokeDetail = viewModel.pokeDetail {
                if let id = pokeDetail.id {
                    AsyncImage(url: URL(string: "\(ApiConstants.imageRenderer)\(id).png"))
                        .frame(width: 150, height: 150)
                }
                Text(pokeDetail.name.capitalized)
                    .font(.largeTitle)
                    .bold()
            }
        }
        .onAppear {
            viewModel.fetchPokeDetail(name: pokeName)
        }
        .onReceive(viewModel.$pokeDetail) { pokeDetail in
            if let id = pokeDetail?.id {
                viewModel.fetchPokeEvolutionDetails(id: id)
            }
        }
        .navigationTitle("TITLE")
    }
}
