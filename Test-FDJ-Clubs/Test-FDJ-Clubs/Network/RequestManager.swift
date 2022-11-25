//
//  RequestManager.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import Foundation

enum NetworkError: Error {
	case badUrl
	case invalidStatusCode
	case invalidResponse
	case noData
	case serialization
}

class RequestManager {
	
	static let shared = RequestManager()
	
	internal func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) where T: Decodable {
		if let url = URL(string: route) {
			let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
				if let error {
					callback?(Result.failure(error))
				} else if let result = response as? HTTPURLResponse {
					if result.statusCode == 200 {
						if let data {
							do {
								let model = try JSONDecoder().decode(type, from: data)
								callback?(Result.success(model))
							} catch {
								print(error)
								callback?(Result.failure(NetworkError.serialization))
							}
						} else {
							callback?(Result.failure(NetworkError.noData))
						}
					} else {
						callback?(Result.failure(NetworkError.invalidStatusCode))
					}
				} else {
					callback?(Result.failure(NetworkError.invalidResponse))
				}
			})
			
			task.resume()
			
		} else {
			callback?(Result.failure(NetworkError.badUrl))
		}
	}
}
