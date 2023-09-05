//
//  BrowserViewModel.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 30/8/23.
//

import Foundation

// MARK: - BrowseSectionType
enum BrowseSectionType {
    case characters(model: [CharacterViewModelCell])
    case location(model: [LocationViewModelCell])
    case episode(model:[EpisodeViewModelCell])
    
    var title: String {
        switch self {
        case .characters:
            return "Characters"
        case .location:
            return "Locations"
        case .episode:
            return "Episode"
        }
    }
}

class BrowserViewModel {
    // MARK: - Poperties
    var service: BrowseService?

    var dataBrowser = [BrowseSectionType]()

    // MARK: - init
    
    init(service: BrowseService = BrowseService() ) {
        self.service = service
    }
    
    // MARK: - Methods
    func fechData(completion: @escaping (Result<[BrowseSectionType], Error>) -> Void) {
    
        var charactersSectionType: [CharacterViewModelCell] = []
        var locationsSectionType: [LocationViewModelCell] = []
        var episodesSectionType: [EpisodeViewModelCell] = []
        
//        Characters
        self.service?.getCharacters(completion: {  result in
            switch result {
            case .success(let character):
                charactersSectionType = character.results.compactMap {
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
                self.dataBrowser.append(.characters(model: charactersSectionType))
                completion(.success(self.dataBrowser))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
//        Locations
        self.service?.getLocations(completion: { result in
            switch result {
            case .success(let location):
                locationsSectionType = location.results.compactMap({
                    LocationViewModelCell(name: $0.name, type: $0.type, dimension: $0.dimension, url: $0.url, residents: $0.residents)
                })
                self.dataBrowser.append(.location(model: locationsSectionType))
                completion(.success(self.dataBrowser))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
//        Episodes
        self.service?.getEpisodes(completion: { result in
            switch result {
            case .success(let episodes):
                episodesSectionType = episodes.results.compactMap({
                    EpisodeViewModelCell(name: $0.name, airDate: $0.airDate, episode: $0.episode, characters: $0.characters)
                })
                self.dataBrowser.append(.episode(model: episodesSectionType))
                completion(.success(self.dataBrowser))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    
}
// MARK: - CharacterViewModelCell

struct CharacterViewModelCell {
    let id: Int
    let name, status, species, type: String
    let artWork: URL?
    let origin, location: String
    let episode: [String]
    let gender: String    
}

// MARK: - LocationViewModelCell

struct LocationViewModelCell {
    
    let name, type, dimension, url : String
    let residents: [String]?
    

}

// MARK: - EpisodeViewModelCell
struct EpisodeViewModelCell {
    let name, airDate, episode: String
    let characters: [String]?
}
