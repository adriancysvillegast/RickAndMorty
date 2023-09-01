//
//  AllLocationResponse.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 31/8/23.
//

import Foundation

struct AllLocationResponse: Codable  {
    let info: Info
    let results: [UbicationResponse]
}
