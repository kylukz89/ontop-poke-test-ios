import SwiftUI

struct PokeItemView: View {
    let id: Int
    let name: String

    var body: some View {
        ZStack {
            // Fundo cinza com bordas arredondadas
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 140)

            VStack(spacing: 0) {
                AsyncImage(url: ApiConstants.createPokemonImageURL(for: id)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .offset(y: -30)
                } placeholder: {
                    ProgressView()
                }
                
                Text("#\(String(format: "%03d", id)) \(name.capitalized)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black.opacity(0.7))
                    )
                    .offset(y: -15)
            }
        }
//        .frame(width: 150, height: 120)
    }
}

