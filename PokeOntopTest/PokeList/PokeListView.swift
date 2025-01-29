import SwiftUI

struct PokeListView: View {
    
    @StateObject private var viewModel = PokeListViewModel()
    @State private var showScrollToTopButton = false
    @State private var scrollProxy: ScrollViewProxy?
    @State private var errorScreenType: ErrorScreenType?

    private let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        BaseView(errorType: $errorScreenType) {
            NavigationView {
                ZStack {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: gridColumns, spacing: 8) {
                                ForEach(Array(viewModel.pokemonList.enumerated()), id: \.element.name) { index, pokemon in
                                    NavigationLink {
                                        PokeDetailView(pokeName: pokemon.name)
                                    } label: {
                                        PokeItemView(id: index + 1, name: pokemon.name)
                                            .padding()
                                    }
                                    .id(index)
                                    .onAppear {
                                        showScrollToTopButton = index >= Constants.minScrollSizeButtonScrollTop
                                         
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
                        .onAppear {
                            self.scrollProxy = proxy
                        }
                        .onChange(of: viewModel.pokemonList.count) { _, _ in
                            checkIfShouldShowButton()
                        }
                    }
                    
                    if showScrollToTopButton {
                        VStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    scrollProxy?.scrollTo(0, anchor: .topLeading)
                                }
                                showScrollToTopButton = false
                            }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.blue)
                                    .background(Circle().fill(Color.white).shadow(radius: 3))
                            }
                            .padding(.bottom, 20)
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

    private func checkIfShouldShowButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let firstIndex = viewModel.pokemonList.indices.first, firstIndex < 60 {
                showScrollToTopButton = false
            }
        }
    }
}

#Preview {
    PokeListView()
}
