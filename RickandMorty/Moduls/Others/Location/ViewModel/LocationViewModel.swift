//
//  LocationViewModel.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/23.
//

import Foundation

class LocationViewModel{
    // MARK: - Properties
    private var service: LocationService?
    
    private var characters = [CharacterResponse]()
    
    
    init(service: LocationService = LocationService()) {
        self.service = service
    }
    
    // MARK: - Methods
    
    func getResident(residentsArray: [String]? ,completion: @escaping (Result<[CharacterViewModelCell], Error>) -> Void ) {
        guard let resident = residentsArray else {
            return
        }
        
        for character in resident {
            service?.getResident(
                urlString: character,
                completion: { result in
                    switch result {
                    case .success(let model):
                        self.characters.append(model)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
        }
        
        let residentsCell = self.characters.compactMap {
            CharacterViewModelCell(id: $0.id, name: $0.name,status: $0.status, species: $0.species, type: $0.type, artWork: URL(string: $0.image), origin: $0.origin.name, location: $0.location.name, episode: $0.episode, gender: $0.gender)
        }
        completion(.success(residentsCell))
        
    }
}
