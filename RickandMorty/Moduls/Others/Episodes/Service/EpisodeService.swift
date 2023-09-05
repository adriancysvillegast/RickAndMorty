//
//  EpisodeService.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/9/23.
//

import Foundation

class EpisodeService {
    
    // MARK: - Properties
    
    
    // MARK: - Methods
    func getResident(urlString: String, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        APIManager.shared.get(
            url: URL(string: urlString),
            expecting: CharacterResponse.self) { result in
                switch result {
                case .success(let resident):
                    completion(.success(resident))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
