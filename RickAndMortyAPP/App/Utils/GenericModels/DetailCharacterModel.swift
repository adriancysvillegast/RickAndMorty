//
//  ResultCharacterModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import Foundation

struct DetailCharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: OriginModel
    let location: CharacterLocationModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
