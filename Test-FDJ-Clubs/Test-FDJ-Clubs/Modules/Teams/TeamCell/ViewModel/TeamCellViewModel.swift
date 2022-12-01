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
			guard let imageUrl = team.logoUrl,
				  let image = try await requestManager?.fetchPhoto(url: imageUrl)
			else { return }
			
			self.image = image
		}
	}
	
}
