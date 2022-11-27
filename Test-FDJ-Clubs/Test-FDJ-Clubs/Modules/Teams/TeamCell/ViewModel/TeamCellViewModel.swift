//
//  TeamCellViewModel.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 27/11/2022.
//

import Foundation
import UIKit.UIImage

class TeamCellViewModel: ObservableObject {
	
	@Published
	var image: UIImage?
	var requestManager: RequestManager?
	
	// MARK: - Init
	required init() { }
	
	init(manager: RequestManager) {
		requestManager = manager
	}
	
	func loadImage(from team: Team) {
		Task {
			guard let imageUrl = team.url
			else { return }
			
			switch try await requestManager?.fetchPhoto(url: imageUrl) {
			case .success(let image):
				self.image = image
			case .failure(let error):
				print(error)
			default: break
			}
		}
	}
	
}
