//
//  AllCharacterResponse.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 31/8/23.
//

import Foundation

struct AllCharacterResponse: Codable {
    let info: Info
    let results: [CharacterResponse]
}


