//
//  Team.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 26/11/2022.
//

import Foundation

struct Teams: Decodable {
	let teams: [Team]?
}

struct Team: Decodable {
	
	let id: String?
	let url: String?
	let name: String?
	
	enum CodingKeys: String, CodingKey {
		case id = "idTeam"
		case url = "strTeamLogo"
		case name = "strAlternate"
	}
	
}
