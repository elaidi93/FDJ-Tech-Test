//
//  TestLeaguesViewModel.swift
//  Test-FDJ-ClubsTests
//
//  Created by Hamza EL Aidi on 28/11/2022.
//

import Foundation

import XCTest
import Combine
@testable import Test_FDJ_Clubs

final class TestLeaguesViewModel: XCTestCase {
	
	private var subscribers = Set<AnyCancellable>()
	private let leaguesVM = LeaguesViewModel(manager: RequestManager())
	private let league = League(id: "1",
								name: "League1 France",
								sport: "Soccer",
								leagueAlternate: "League1")
	
	func testTeam() {
		XCTAssertEqual(league.id, "1")
		XCTAssertEqual(league.name, "League1 France")
		XCTAssertEqual(league.sport, "Soccer")
		XCTAssertEqual(league.leagueAlternate, "League1")
	}
	
	func testEmptyLeaguesList() {
		XCTAssertNil(leaguesVM.leagues)
	}
	
	func testRequestManagerNil() {
		XCTAssertNotNil(leaguesVM.requestManager)
	}
	
	func testGetLeagues() throws {
		
		leaguesVM.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { _ in
				do {
					let leagues = try XCTUnwrap(self.leaguesVM.leagues)
					XCTAssertTrue(leagues.count > 0)
				} catch {
					XCTFail("error")
				}
				
		}).store(in: &self.subscribers)
	}
	
	func testFiltredLeaguesList() {
		leaguesVM.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { _ in
				do {
					self.leaguesVM.filterList(with: "league1")
					let filtredList = try XCTUnwrap(self.leaguesVM.filtredList)
					
					XCTAssertTrue(filtredList.count > 0)
					
					let exist = try XCTUnwrap(filtredList.first?.name?.contains("league1"))
					let notExist = try XCTUnwrap(filtredList.first?.name?.contains("Premier League"))
					
					XCTAssertTrue(exist)
					XCTAssertFalse(notExist)
				} catch {
					XCTFail("error")
				}
				
		}).store(in: &self.subscribers)
	}
}
