//
//  ListModel.swift
//  PokeTest
//
//  Created by Igor Maximo on 27/01/25.
//

import Foundation

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String
    let sprites: Sprites

    var imageUrl: String {
        sprites.frontDefault ?? ""
    }
}

struct Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// Root model
struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}

// Result model
struct PokemonResult: Identifiable, Codable {
    let id = UUID().uuidString
    let name: String
    let url: String
}

