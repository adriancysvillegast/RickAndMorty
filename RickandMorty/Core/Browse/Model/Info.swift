//
//  Info.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 31/8/23.
//

import Foundation

struct Info: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}
