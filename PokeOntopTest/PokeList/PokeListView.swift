 
import SwiftUI

struct PokeListView: View {
    
    @StateObject private var viewModel = PokeListViewModel()
    
    private let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        BaseView {
            NavigationView {
                VStack {
                    ScrollView {
                        LazyVGrid(columns: gridColumns, spacing: 8) {
                            ForEach(Array(viewModel.pokemonList.enumerated()), id: \.element.name) { index, pokemon in
                                NavigationLink {
                                    PokeDetailView(pokeName: pokemon.name)
                                } label: {
                                    PokeItemView(id: index + 1, name: pokemon.name)
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
                        .padding(.horizontal)
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
