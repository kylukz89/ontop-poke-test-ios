//
//  PokemonHorizontalList.swift
//  PokeOntopTest
//
//  Created by Igor Maximo on 28/01/25.
//

import SwiftUI

struct PokemonHorizontalList: View {
    let pokemons: [PokeDetail]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(pokemons) { pokemon in
                    VStack {
                        AsyncImage(url: URL(string: "\(ApiConstants.imageRenderer)\(pokemon.id).png")) { image in
                            image
                                .resizable()
                                .frame(width: 150, height: 150)
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                                .frame(width: 150, height: 150)
                        }
                        Text(pokemon.name.capitalized)
                            .font(.headline)
                            .lineLimit(1)
                            .frame(maxWidth: 150)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 150)
                }
            }
            .padding(.horizontal)
        }
    }
}
