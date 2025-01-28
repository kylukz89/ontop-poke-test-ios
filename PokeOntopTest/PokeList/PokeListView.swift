//
//  PokemonListView.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import SwiftUI

struct PokeListView: View {
    
    @StateObject private var viewModel = PokeListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.pokemonList, id: \.id) { pokemon in
                        NavigationLink {
                            PokemonDetailView(pokemon: pokemon)
                        } label: {
                            HStack {
                                Text(pokemon.name.capitalized)
                                    .font(.title)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Pokémon List")
        }
        .onAppear {
            viewModel.fetchPokemonList()
        }
    }
}

#Preview {
    PokeListView()
}
