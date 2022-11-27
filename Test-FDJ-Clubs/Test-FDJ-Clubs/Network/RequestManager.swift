//
//  RequestManager.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import Foundation
import UIKit.UIImage

enum NetworkError: Error {
	case badUrl
	case invalidStatusCode
	case invalidResponse
	case noData
	case serialization
}

class RequestManager {
	
	func get<T>(_ type: T.Type, route: String, callback: ((Result<T, Error>) -> Void)?) async throws where T: Decodable {
		
		guard let url = URL(string: route) else {
			callback?(Result.failure(NetworkError.badUrl))
			return
		}
		
		do {
			let model = try JSONDecoder().decode(type, from: try await request(url))
			callback?(.success(model))
		} catch {
			print(error)
			callback?(.failure(NetworkError.serialization))
		}
	}
	
	// Load Image
	func fetchPhoto(url: String) async throws -> Result<UIImage, Error> {
		
		guard let url = URL(string: url) else {
			return Result.failure(NetworkError.badUrl)
		}
		
		guard let image = UIImage(data: try await request(url)) else {
			throw NetworkError.serialization
		}
		
		return .success(image)
	}
	
	// request
	
	private func request(_ url: URL) async throws -> Data {
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse else {
			throw NetworkError.invalidResponse
		}
		
		guard response.statusCode == 200 else {
			throw NetworkError.invalidStatusCode
		}
		
		return data
	}
}
