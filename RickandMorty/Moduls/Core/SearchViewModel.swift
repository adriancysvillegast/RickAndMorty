//
//  SearchViewModel.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 5/9/23.
//

import Foundation

class SearchViewModel {
    // MARK: - Properties
    private var service: SearchService
    
    init(service: SearchService = SearchService() ) {
        self.service = service
    }
    // MARK: - Methods
    
    func fetch(query: String, completion: @escaping (Result<[CharacterViewModelCell]?, Error>) -> Void) {
        
        service.searchCharacter(query: query) { result in
            switch result {
            case .success(let model):
                let characterCell = model.results?.compactMap {
                        CharacterViewModelCell(
                            id: $0.id,
                            name: $0.name,
                            status: $0.status,
                            species: $0.species,
                            type: $0.type,
                            artWork: URL(string: $0.image),
                            origin: $0.origin.name,
                            location: $0.location.url,
                            episode: $0.episode,
                            gender: $0.gender
                        )
                    }
                    completion(.success(characterCell))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
