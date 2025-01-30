 
import SwiftUI

struct PokemonHorizontalList: View {
    
    let pokemons: [PokeDetail]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                let size: CGFloat = 150
                ForEach(pokemons, id:\.name) { pokemon in
                    VStack {
                        let pokemonID = pokemon.url.extraIdByURL()
                        AsyncImage(url: URL(string: "\(ApiConstants.imageRenderer)\(pokemonID).png")) { image in
                            image
                                .resizable()
                                .frame(width: size, height: size)
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                                .frame(width: size, height: size)
                        }
                        Text(pokemon.name.capitalized)
                            .font(.headline)
                            .lineLimit(1)
                            .frame(maxWidth: size)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: size)
                }
            }
            .padding(.horizontal)
        }
    }
}
