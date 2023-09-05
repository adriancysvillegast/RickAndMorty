//
//  EpisodeViewModel.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/9/23.
//

import Foundation

class EpisodeViewModel {
    // MARK: - Properties
    private var service: EpisodeService?
    
    private var characters = [CharacterResponse]()
    
    
    init(service: EpisodeService = EpisodeService()) {
        self.service = service
    }
    
    // MARK: - Methods
    
    func getCharacters(charactersString: [String]?,
                       completion: @escaping (Result<[CharacterViewModelCell], Error>)-> Void) {
        guard let urlString = charactersString else {
            return
        }

        for url in urlString {
            service?.getResident(
                urlString: url,
                completion: { [weak self] result in
                    switch result {
                    case .success(let model):
                        self?.characters.append(model)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
        }
        let charactersCell = characters.compactMap {
            CharacterViewModelCell(id: $0.id, name: $0.name,status: $0.status, species: $0.species, type: $0.type, artWork: URL(string: $0.image), origin: $0.origin.name, location: $0.location.name, episode: $0.episode, gender: $0.gender)
        }
        completion(.success(charactersCell))
    }
    
}
