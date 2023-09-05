//
//  CharacterViewModel.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import Foundation

class CharacterViewModel {
    // MARK: - Properties
    private var episodes: [EpisodeResponse] = []
    
    private var service: CharacterService?
    
    init(service: CharacterService = CharacterService()) {
        self.service = service
    }
    
    // MARK: - Methods
    
    func getEpisodes(
        character: CharacterViewModelCell,
        completion: @escaping (Result<[EpisodeViewModelCell], Error>) -> Void) {
            let episodes = character.episode
            
            for episode in episodes {
                service?.getEpisodes(url: episode, completion: { [weak self] result in
                    switch result {
                    case .success(let model):
                        self?.episodes.append(model)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
            let episodesCell = self.episodes.compactMap {
                EpisodeViewModelCell(name: $0.name, airDate: $0.airDate, episode: $0.episode, characters: $0.characters)
            }
            completion(.success(episodesCell))
    }
 
    
}
