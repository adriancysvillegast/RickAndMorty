//
//  BrowseService.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 29/8/23.
//

import Foundation

class BrowseService {
    // MARK: - properties
    private let baseURL: String = ProcessInfo.processInfo.environment["baseURL"] ?? "https://rickandmortyapi.com/api"
    
    public enum EndPoint: String {
        case character = "/character/"
        case location = "/location"
        case episode = "/episode/"
    }
    // MARK: - Methods
    
    func getCharacters(completion: @escaping (Result<AllCharacterResponse, Error>) -> Void) {
        APIManager.shared.get(
            url: URL(string: "\(baseURL)/character"),
            expecting: AllCharacterResponse.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error) :
                    print(error)
                    completion(.failure(error))
                }
            }
    }
}

