 
import SwiftUI

struct PokeListView: View {
    
    @StateObject private var viewModel = PokeListViewModel()
    
    var body: some View {
        BaseView {
            NavigationView {
                VStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.pokemonList, id: \.id) { pokemon in
                                NavigationLink {
                                    PokeDetailView(pokeName: pokemon.name)
                                } label: {
                                    HStack {
                                        Text(pokemon.name.capitalized)
                                            .font(.title)
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                            
                            if viewModel.hasMoreData {
                                ProgressView()
                                    .padding()
                                    .onAppear {
                                        viewModel.fetchPokemonList()
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("Pokémon List")
            }
        }
        .onAppear {
            viewModel.fetchPokemonList()
        }
    }
}

#Preview {
    PokeListView()
}
