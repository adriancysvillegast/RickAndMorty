//
//  ApiManager.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    private init (){}
    
    func get(urlString: String, onComplition: @escaping (Data?) -> (), onError: @escaping (Error?) -> () ) {
        guard let url = URL(string: urlString) else { return }
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { data, response, error in
            if error != nil {
                onError(error)
            }
            onComplition(data)
            
        }
        task.resume()
    }
}
