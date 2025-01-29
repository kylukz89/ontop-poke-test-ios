 
import SwiftUI

struct PokeDetailView: View {
    
    @StateObject private var viewModel = PokeDetailViewModel()
    
    let pokeName: String

    var body: some View {
        BaseView {
            VStack(spacing: 20) {
                if let pokeDetail = viewModel.pokeDetail {
                    if let id = pokeDetail.id {
                        AsyncImage(url: ApiConstants.createPokemonImageURL(for: id)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 200, height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .foregroundColor(.red)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    Text(pokeDetail.name.capitalized)
                        .font(.largeTitle)
                        .bold()
                    
                    if !$viewModel.speciesList.isEmpty {
                        Text("Evolution Chain")
                            .font(.title2)
                            .bold()
                            .padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.speciesList, id: \.name) { specie in
                                    let id = specie.url.extraIdByURL()
                                    NavigationLink(destination: PokeDetailView(pokeName: specie.name)) {
                                        PokeItemView(id: id, name: specie.name)
                                    }
                                }
                            }
                            .padding()
                        }

                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPokeDetail(name: pokeName)
        }
        .onReceive(viewModel.$pokeDetail) { pokeDetail in
            if let pokeDetail = pokeDetail {
                let pokemonID = pokeDetail.evolutionChain?.url.extraIdByURL()
                viewModel.fetchPokeEvolutionDetails(id: pokemonID ?? -1)
            }
        }
        .navigationTitle("Pokemon Detail")
    }
}
