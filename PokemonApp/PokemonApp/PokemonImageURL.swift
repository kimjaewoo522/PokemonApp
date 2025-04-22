//
//  PokemonImageURL.swift
//  PokemonApp
//
//  Created by 김재우 on 4/22/25.
//
import Foundation

struct PokemonImageURL: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
