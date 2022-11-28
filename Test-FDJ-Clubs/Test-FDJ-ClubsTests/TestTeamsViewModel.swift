//
//  TestTeamsViewModel.swift
//  Test-FDJ-ClubsTests
//
//  Created by Hamza EL Aidi on 28/11/2022.
//

import XCTest
import Combine
@testable import Test_FDJ_Clubs

final class TestTeamsViewModel: XCTestCase {
	
	private var subscribers = Set<AnyCancellable>()
	let teamsVM = TeamsViewModel(manager: RequestManager())
	
	private let team = Team(id: "1",
							logoUrl: "logo",
							name: "team1",
							banner: "banner",
							country: "France",
							league: "League1",
							description: "description")
	
	func testTeam() {
		XCTAssertEqual(team.id, "1")
		XCTAssertEqual(team.logoUrl, "logo")
		XCTAssertEqual(team.name, "team1")
		XCTAssertEqual(team.banner, "banner")
		XCTAssertEqual(team.country, "France")
		XCTAssertEqual(team.league, "League1")
		XCTAssertEqual(team.description, "description")
	}
	
	func testEmptyLeaguesList() {
		XCTAssertNil(teamsVM.teams)
	}
	
	func testRequestManagerNil() {
		XCTAssertNotNil(teamsVM.requestManager)
	}
	
	func testGetLeagues() throws {
		
		teamsVM.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { _ in
				do {
					let teams = try XCTUnwrap(self.teamsVM.teams)
					XCTAssertTrue(teams.count > 0)
				} catch {
					XCTFail("error")
				}
				
		}).store(in: &self.subscribers)
	}
	
	func testRoute() {
		do {
			let route1 = try XCTUnwrap(teamsVM.getTeamsRoute(from: "League1"))
			XCTAssertNotEqual(route1, Constants.urls.teams_list + "League1")
			XCTAssertEqual(route1, Constants.urls.teams_list + "league1")
			
			let route2 = try XCTUnwrap(teamsVM.getTeamsRoute(from: "Premier League"))
			XCTAssertNotEqual(route2, Constants.urls.teams_list + "Premier League")
			let team = try XCTUnwrap("premier league".urlHost)
			XCTAssertEqual(route2, Constants.urls.teams_list + team)
		} catch {
			XCTFail("error")
		}
	}
	
	func testSortedList() {
		let team1 = Team(id: "2", logoUrl: "", name: "Marseille", banner: "", country: "", league: "", description: "")
		let team2 = Team(id: "1", logoUrl: "", name: "Paris SG", banner: "", country: "", league: "", description: "")
		let team3 = Team(id: "3", logoUrl: "", name: "Lyon", banner: "", country: "", league: "", description: "")
		
		let sortedList = teamsVM.sorte(teams: [team1, team2, team3])
		
		XCTAssertNotEqual(sortedList, [team3, team2, team1])
		XCTAssertNotEqual(sortedList, [team2, team3, team1])
		
	}
	
}
