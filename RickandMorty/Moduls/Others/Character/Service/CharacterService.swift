//
//  CharacterService.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import Foundation

class CharacterService {
    // MARK: - Properties

    
    // MARK: - Methods
    
    func getEpisodes(
        url: String,
        completion: @escaping (Result<EpisodeResponse, Error>) -> Void) {
            APIManager.shared.get(
                url: URL(string: url),
                expecting: EpisodeResponse.self) { result in
                    switch result {
                    case .success(let ubication):
                        completion(.success(ubication))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
}
