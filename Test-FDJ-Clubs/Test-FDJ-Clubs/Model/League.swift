//
//  League.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import Foundation

struct Leagues: Decodable {
	let leagues: [League]?
}

public struct League: Decodable {
	let id: String?
	let name: String?
	let sport: String?
	let leagueAlternate: String?

	enum CodingKeys: String, CodingKey {
		case id = "idLeague"
		case name = "strLeague"
		case sport = "strSport"
		case leagueAlternate = "strLeagueAlternate"
	}
}
