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
	
	func get<T: Decodable>(_ type: T.Type, route: String) async -> Result<T, Error> {
		
		guard let url = URL(string: route) else {
			return .failure(NetworkError.badUrl)
		}
		
		do {
			let model = try JSONDecoder().decode(type,
												 from: try await request(url))
			return .success(model)
		} catch {
			print(error)
			return .failure(NetworkError.serialization)
		}
	}
	
	// Load Image
	func fetchPhoto(url: String) async throws -> UIImage {
		
		guard let url = URL(string: url) else {
			throw NetworkError.badUrl
		}
		
		guard let image = UIImage(data: try await request(url)) else {
			throw NetworkError.serialization
		}
		
		return image
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
