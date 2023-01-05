//
//  EpisodeModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

struct EpisodeModel: Codable {
    
    let info: InfoModel
    let results: [EpisodesDetailModel]
}
