//
//  AllEpisodeResponse.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 31/8/23.
//

import Foundation

struct AllEpisodeResponse: Codable {
    let info: Info
    let results : [EpisodeResponse]
}
