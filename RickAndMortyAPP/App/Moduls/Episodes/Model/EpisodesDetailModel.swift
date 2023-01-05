//
//  EpisodesDetailModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

struct EpisodesDetailModel: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
}
