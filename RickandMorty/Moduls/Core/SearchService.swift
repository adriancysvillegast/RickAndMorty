//
//  SearchService.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 5/9/23.
//

import Foundation

class SearchService {
    // MARK: - Properties
    
    private let baseURL: String = ProcessInfo.processInfo.environment["baseURL"] ?? "https://rickandmortyapi.com/api"
    
    // MARK: - Methods
    
    func searchCharacter(query: String,
                         completion: @escaping (Result<CharacterSearchResponse, Error>) -> Void ) {
        APIManager.shared.get(
            url: URL(string:"\(baseURL)/character/?name=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
            expecting: CharacterSearchResponse.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
