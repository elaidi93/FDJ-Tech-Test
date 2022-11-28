//
//  TeamsViewModel.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 26/11/2022.
//

import Foundation
import Combine

class TeamsViewModel: ObservableObject {
	
	@Published
	var teams: [Team]?
	private var requestManager: RequestManager?
	
	// MARK: - Init
	required init() { }
	
	init(manager: RequestManager) {
		requestManager = manager
	}
	
	func fetchTeams(from league: League) {
		Task {
			guard let route = self.getTeamsRoute(from: league)
			else { return }
			
			try await requestManager?.get(Teams.self,
										  route: route) {
				[weak self] result in
				
				switch result {
				case .success(let teams):
					guard let teams = teams.teams
					else { return }
					
					self?.teams = self?.sorte(teams: teams)
					
				case .failure(let error):
					print(error)
				}
			}
		}
	}
	
	private func getTeamsRoute(from league: League) -> String? {
		guard let leagueName = league.name?.urlHost
		else { return nil }
		return Constants.urls.teams_list + leagueName
	}
	
	private func sorte(teams: [Team]) -> [Team] {
		let sortedTeams = teams.sorted(by: { team1, team2 in
			guard let name1 = team1.name,
				  let name2 = team2.name
			else { return true }
			return name1 > name2
		})
		
		return sortedTeams
	}
}
