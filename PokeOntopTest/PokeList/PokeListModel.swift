//
//  ListModel.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import Foundation

struct PokeDetail: Identifiable, Codable {
    let id: Int?
    let name: String
    let url: String?
}

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}

struct PokemonResult: Identifiable, Codable {
    let id = UUID().uuidString
    let name: String
    let url: String
}
