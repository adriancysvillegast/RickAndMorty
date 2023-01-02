//
//  HomeService.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import Foundation

protocol MovieServiceFetching {
    func get(onComplete: @escaping () -> () , onError: @escaping (String?) -> ())
}

class HomeService {
    
}
