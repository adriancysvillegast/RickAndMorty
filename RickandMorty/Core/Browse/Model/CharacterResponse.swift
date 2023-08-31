//
//  CharacterResponse.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 29/8/23.
//

import Foundation

struct CharacterResponse: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

