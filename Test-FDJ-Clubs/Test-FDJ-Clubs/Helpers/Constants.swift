//
//  Constants.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import Foundation

enum Constants {
	enum Leagues {
		static let searchBar_placeholder = "Search by league"
		static let title = "Leagues"
	}
	
	enum urls {
		static private let base = "https://www.thesportsdb.com/api/v1/json/50130162/"
		static let leagues_url = "\(base)all_leagues.php"
		static let teams_list = "s\(base)earch_all_teams.php?l=French%20Ligue%201"
		static let team_details = "\(base)searchteams.php?t=Paris%20SG"
	}
}
