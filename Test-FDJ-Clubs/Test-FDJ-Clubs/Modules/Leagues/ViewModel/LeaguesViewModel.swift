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
	private var leagues: [League]?
	private var requestManager: RequestManager?
	
	init(manager: RequestManager) {
		requestManager = manager
	}
	
	func getLeagues() {
		Task {
			try await requestManager?.get(Leagues.self,
								route: Constants.urls.leagues_url) {
				result in
				
				DispatchQueue.main.async {
					switch result {
					case .success(let leagues):
						self.leagues = leagues.leagues
					case .failure(let error):
						print(error)
					}
				}
			}
		}
	}
	
	func filterList(with text: String) {
		filtredList = text.isEmpty ? nil : leagues?.filter { $0.name?.contains(text) ?? false }
	}
}
