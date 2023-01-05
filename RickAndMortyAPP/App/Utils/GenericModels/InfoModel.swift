//
//  InfoModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import Foundation

class InfoModel: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
