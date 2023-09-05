//
//  LocationService.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/23.
//

import Foundation

class LocationService {
    // MARK: - Properties
    
    // MARK: - Methods
    func getLocations(urlString: String,  completion: @escaping (Result<UbicationResponse, Error>) -> Void) {
        APIManager.shared.get(
            url: URL(string: urlString),
            expecting: UbicationResponse.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error) :
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
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
