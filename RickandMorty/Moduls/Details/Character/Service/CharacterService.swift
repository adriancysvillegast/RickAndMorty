//
//  CharacterService.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import Foundation

class CharacterService {
    // MARK: - Properties
    private let baseURL: String = ProcessInfo.processInfo.environment["baseURL"] ?? "https://rickandmortyapi.com/api"
    
    // MARK: - Methods
    
    func getCharactersInfo(url: String, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        
        APIManager.shared.get(
            url: URL(string: url),
            expecting: CharacterResponse.self) { result in
                switch result {
                case .success(let character):
                    completion(.success(character))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
}
