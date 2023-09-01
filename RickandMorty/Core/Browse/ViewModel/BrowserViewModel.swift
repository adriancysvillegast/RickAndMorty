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
            return "locations"
        case .episode:
            return "Episode"
        }
    }
}

class BrowserViewModel {
    // MARK: - Poperties
    var browseService: BrowseService?

    var dataBrowser = [BrowseSectionType]()

    // MARK: - init
    
    init(service: BrowseService = BrowseService() ) {
        self.browseService = service
    }
    
    // MARK: - Methods
    func fechData(completion: @escaping (Result<[BrowseSectionType], Error>) -> Void) {
    
        var charactersSectionType: [CharacterViewModelCell] = []
        var locationsSectionType: [LocationViewModelCell] = []
        var episodesSectionType: [EpisodeViewModelCell] = []
        
//        Characters
        self.browseService?.getCharacters(completion: {  result in
            switch result {
            case .success(let character):
                charactersSectionType = character.results.compactMap {
                    CharacterViewModelCell(
                        id: $0.id,
                        name: $0.name,
                        species: $0.species,
                        url: URL(string: $0.image)
                    )
                }
                self.dataBrowser.append(.characters(model: charactersSectionType))
                completion(.success(self.dataBrowser))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
//        Locations
        self.browseService?.getLocations(completion: { result in
            switch result {
            case .success(let location):
                locationsSectionType = location.results.compactMap({
                    LocationViewModelCell(name: $0.name, type: $0.type)
                })
                self.dataBrowser.append(.location(model: locationsSectionType))
                completion(.success(self.dataBrowser))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
//        Episodes
        self.browseService?.getEpisodes(completion: { result in
            switch result {
            case .success(let episodes):
                episodesSectionType = episodes.results.compactMap({
                    EpisodeViewModelCell(name: $0.name, airDate: $0.airDate)
                })
                self.dataBrowser.append(.episode(model: episodesSectionType))
                completion(.success(self.dataBrowser))
            case .failure(let error): break
                completion(.failure(error))
            }
        })
        
    }

    
}
// MARK: - CharacterViewModelCell

struct CharacterViewModelCell {
    let id: Int
    let name, species: String
    let url: URL?
}

// MARK: - LocationViewModelCell

struct LocationViewModelCell {
    let name, type : String
}

// MARK: - EpisodeViewModelCell
struct EpisodeViewModelCell {
    let name, airDate: String
}
