//
//  LocationService.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

protocol LocationServiceFetching {
    func get(onComplete: @escaping (LocationsModel) -> (), onError: @escaping (String?) -> () )
}

class LocationService: LocationServiceFetching {
    
    let baseURL: String = ProcessInfo.processInfo.environment["baseURL"] ?? ""
    let endpoint: String = ProcessInfo.processInfo.environment["endpointLocation"] ?? ""
    
    func get(onComplete: @escaping (LocationsModel) -> (), onError: @escaping (String?) -> ()) {
        ApiManager.shared.get(urlString: "\(baseURL)\(endpoint)") { data in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let value = try decoder.decode(LocationsModel.self, from: data)
                onComplete(value)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { e in
            onError(e?.localizedDescription)
        }
    }
}
