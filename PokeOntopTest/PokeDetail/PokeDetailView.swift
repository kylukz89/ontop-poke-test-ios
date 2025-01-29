import SwiftUI

struct PokeDetailView: View {
    
    @StateObject private var viewModel = PokeDetailViewModel()
    @State private var errorScreenType: ErrorScreenType?
    
    let pokeName: String
    
    var body: some View {
        BaseView(errorType: $errorScreenType) {
            ScrollView {
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
                                                .frame(width: 150)
                                        }
                                    }
                                }
                                .padding()
                            }
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
        .onReceive(viewModel.$errorApi) { error in
            if let _ = error {
                errorScreenType = .apiError(retryAction: {
                    viewModel.fetchPokeDetail(name: pokeName)
                })
            } else {
                errorScreenType = nil
            }
        }
        .navigationTitle("Pokemon Detail")
    }
    
    private func determineErrorType() -> ErrorScreenType? {
        if viewModel.pokeDetail == nil {
            return .apiError(retryAction: { viewModel.fetchPokeDetail(name: pokeName) })
        }
        return nil
    }
}
