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
                AsyncImage(url: URL(string: "\(ApiConstants.imageRenderer)\(pokeDetail.id).png"))
                    .frame(width: 150, height: 150)
                Text(pokeDetail.name.capitalized)
                    .font(.largeTitle)
                    .bold()
            }
        }
        .onAppear {
            viewModel.fetchPokeDetail(name: pokeName)
        }
        .navigationTitle("TITLE")
    }
}
