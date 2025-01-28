//
//  PokeDetailProtocols.swift
//  PokeOntopTest
//
//  Created by Igor Maximo on 28/01/25.
//

import Foundation

internal protocol PokeDetailInputProtocol: AnyObject {
    var output: PokeDetailOutputProtocol? { get set }
    func fetchPokeDetail(name: String)
}

internal protocol PokeDetailOutputProtocol: AnyObject {
    func fetchPokeDetailSuccess(response: PokeDetail?)
    func fetchPokeDetailFailure(error: Error)
}
