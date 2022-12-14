//
//  LeaguesViewModel.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import Foundation
import Combine

class LeaguesViewModel: ObservableObject {
	
	@Published
	var filtredList: [League]?
	var leagues: [League]?
	var requestManager: RequestManager?
	
	init(manager: RequestManager) {
		requestManager = manager
	}
	
	func getLeagues() {
		Task {
			guard let result = await requestManager?.get(Leagues.self,
														 route: Constants.urls.leagues_url)
			else { return }
			
			switch result {
			case .success(let leagues):
				self.leagues = leagues.leagues
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func filterList(with text: String) {
		filtredList = text.isEmpty ? nil : leagues?.filter { $0.name?.contains(text) ?? false }
	}
}
