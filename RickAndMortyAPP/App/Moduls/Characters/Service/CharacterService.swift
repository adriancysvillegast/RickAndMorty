//
//  CharacterService.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import Foundation

protocol CharacterServiceFetching {
    func get(onComplete: @escaping (CharacterModel) -> () , onError: @escaping (String?) -> ())
}

class CharacterService: CharacterServiceFetching {
    let baseURL: String = ProcessInfo.processInfo.environment["baseURL"] ?? ""
    let endpoint: String = ProcessInfo.processInfo.environment["endpointCharacter"] ?? ""
    
    func get(onComplete: @escaping (CharacterModel) -> (), onError: @escaping (String?) -> ()) {
        ApiManager.shared.get(urlString: "\(baseURL)\(endpoint)") { data in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let value = try decoder.decode(CharacterModel.self, from: data)
                onComplete(value)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            onError(error?.localizedDescription)
        }
    }
}
