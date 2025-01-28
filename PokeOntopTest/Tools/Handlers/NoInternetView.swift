//
//  NoInternetView.swift
//  PokeOntopTest
//
//  Created by Igor Maximo on 28/01/25.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "wifi.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)

            Text(String(localized: "no_internet_title"))
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)

            Text(String(localized: "no_internet_message"))
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.95))
        .edgesIgnoringSafeArea(.all)
    }
}
