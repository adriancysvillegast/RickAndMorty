//
//  EpisodesService.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

protocol EpisodesServiceFetching {
    func get(onComplite: @escaping (EpisodeModel) -> (), onError: @escaping (String?) -> () )
}

class EpisodesService: EpisodesServiceFetching {
    
    let baseURL: String = ProcessInfo.processInfo.environment["baseURL"] ?? ""
    let endpoint: String = ProcessInfo.processInfo.environment["endpointEpisode"] ?? ""
    
    func get(onComplite: @escaping (EpisodeModel) -> (), onError: @escaping (String?) -> ()) {
        
        ApiManager.shared.get(urlString: "\(baseURL)\(endpoint)") { data in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let value = try decoder.decode(EpisodeModel.self, from: data)
                
                onComplite(value)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            onError(error?.localizedDescription)
        }
    }
}
