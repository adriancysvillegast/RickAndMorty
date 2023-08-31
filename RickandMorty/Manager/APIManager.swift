//
//  APIManager.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 29/8/23.
//

import Foundation

final class APIManager {
    
    // MARK: - Properties
    static let shared = APIManager()
    
    private init (){}
    
    private enum APIError: Error {
        case failedToGetData
        case invalidURL
    }
    
    enum HTTPMethods: String {
        case GET
        case PUT
        case POST
        case DELETE
    }
    
    // MARK: - Methods
    
    func get<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        createRequest(with: url,
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let objec = try decoder.decode(expecting, from: data)
                    completion(.success(objec))
                } catch{
                    print(error)
                    completion(.failure(error))
                }

            }
            task.resume()
        }
    }
    
    // MARK: - Basic Request
    private func createRequest(with url: URL?, type: HTTPMethods,
                               completion: @escaping (URLRequest) -> Void) {
        guard let apiUrl = url else {
            return
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}


