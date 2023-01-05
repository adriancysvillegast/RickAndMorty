//
//  LocationsModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

struct LocationsModel: Codable {
    
    let info: InfoModel
    let results: [DetailLocationModel]
}
