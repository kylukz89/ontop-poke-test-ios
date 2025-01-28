//
//  PokemonDetailView.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import SwiftUI

struct PokemonDetailView: View {
    
    let pokemon: PokemonResult

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: pokemon.url))
                .frame(width: 150, height: 150)
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}
