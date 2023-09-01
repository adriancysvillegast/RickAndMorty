//
//  CharacterViewModel.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import Foundation

class CharacterViewModel {
    // MARK: - Properties
    
    private var characterService: CharacterService?
    
    init(service: CharacterService = CharacterService()) {
        self.characterService = service
    }
    
    // MARK: - Methods
    
    func fetchDetail(url: String,
                     completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        APIManager.shared.get(url: URL(string: url),
                              expecting: CharacterResponse.self) { result in
            switch result {
            case .success(let character):
                print(character)
            case .failure(let error):
                print(error)
            }
        }
    }
}
