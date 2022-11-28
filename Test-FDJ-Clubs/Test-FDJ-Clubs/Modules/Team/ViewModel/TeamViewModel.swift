//
//  TeamViewModel.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 28/11/2022.
//

import Foundation
import UIKit.UIImage

class TeamViewModel: ObservableObject {
	
	@Published
	var banner: UIImage?
	var team: Team?
	private var requestManager: RequestManager?
	
	init(team: Team, requestManager: RequestManager) {
		self.team = team
		self.requestManager = requestManager
	}
	
	func loadImage() {
		Task {
			guard let imageUrl = team?.banner
			else { return }
			
			switch try await requestManager?.fetchPhoto(url: imageUrl) {
			case .success(let image):
				self.banner = image
			case .failure(let error):
				print(error)
			default: break
			}
		}
	}
}
