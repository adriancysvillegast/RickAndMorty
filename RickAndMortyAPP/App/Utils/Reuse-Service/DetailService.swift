//
//  DetailService.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 3/1/23.
//

import Foundation

protocol DetailServiceFetching {
    func getDetailCharacter(url: String, onComplete: @escaping (DetailCharacterModel) -> (), onError: @escaping (String?) -> () )
    func getDetailLocation(url: String, onComplete: @escaping (DetailLocationModel) -> (), onError: @escaping (String?) -> ())
}

class DetailService: DetailServiceFetching{
    
    func getDetailLocation(url: String, onComplete: @escaping (DetailLocationModel) -> (), onError: @escaping (String?) -> ()) {
        ApiManager.shared.get(urlString: url) { data in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let value = try decoder.decode(DetailLocationModel.self, from: data)
                onComplete(value)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            onError(error?.localizedDescription)
        }
    }
    
    func getDetailCharacter(url: String, onComplete: @escaping (DetailCharacterModel) -> (), onError: @escaping (String?) -> ()) {
        ApiManager.shared.get(urlString: url) { data in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let value = try decoder.decode(DetailCharacterModel.self, from: data)
                onComplete(value)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { e in
            onError(e?.localizedDescription)
        }
    }
}
