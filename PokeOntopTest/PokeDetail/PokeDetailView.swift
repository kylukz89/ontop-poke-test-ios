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
                if !$viewModel.speciesList.isEmpty {
                    Text("Evolution Chain")
                        .font(.title2)
                        .bold()
                        .padding(.top, 10)
                    PokemonHorizontalList(pokemons: viewModel.speciesList)
                        .frame(height: 150)
                }
            }
        }
        .onAppear {
            viewModel.fetchPokeDetail(name: pokeName)
        }
        .onReceive(viewModel.$pokeDetail) { pokeDetail in
            if let pokeDetail = pokeDetail {
                var pokemonID: String {
                    print("=====\(pokeDetail.url)")
                    guard let url = pokeDetail.url else { return "-1" }
                    let components = url.split(separator: "/").map(String.init)
                    return components.last ?? "-1"
                }
                viewModel.fetchPokeEvolutionDetails(id: Int(pokemonID) ?? -1)
            }
        }
        .navigationTitle("TITLE")
    }
}
