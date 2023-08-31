//
//  BrowserViewModel.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 30/8/23.
//

import Foundation

class BrowserViewModel {
    // MARK: - Poperties
    
    var browseService: BrowseService?
    // MARK: - init
    init(service: BrowseService = BrowseService() ) {
        self.browseService = service
    }
    
    // MARK: - Methods
    
    func fetchData(completion: @escaping (Result<AllCharacterResponse, Error>) -> Void) {
        self.browseService?.getCharacters(completion: { result in
            switch result {
            case .success(let character):
                completion(.success(character))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
