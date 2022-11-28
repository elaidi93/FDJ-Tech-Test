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

public struct Team: Decodable, Equatable {
	
	let id: String?
	let logoUrl: String?
	let name: String?
	let banner: String?
	let country: String?
	let league: String?
	let description: String?
	
	enum CodingKeys: String, CodingKey {
		case id = "idTeam"
		case logoUrl = "strTeamBadge"
		case name = "strTeam"
		case banner = "strTeamBanner"
		case country = "strCountry"
		case league = "strLeague"
		case description = "strDescriptionEN"
	}
}
