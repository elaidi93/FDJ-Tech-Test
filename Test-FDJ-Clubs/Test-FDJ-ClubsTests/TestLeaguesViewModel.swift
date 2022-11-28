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
	let leagueVM = LeaguesViewModel(manager: RequestManager())
	
	func testEmptyLeaguesList() {
		XCTAssertNil(leagueVM.leagues)
	}
	
	func testGetLeagues() throws {
		
		leagueVM.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { _ in
				do {
					let leagues = try XCTUnwrap(self.leagueVM.leagues)
					XCTAssertTrue(leagues.count > 0)
				} catch {
					XCTFail("error")
				}
				
		}).store(in: &self.subscribers)
	}
	
	func testFiltredLeaguesList() {
		leagueVM.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { _ in
				do {
					self.leagueVM.filterList(with: "league1")
					let filtredList = try XCTUnwrap(self.leagueVM.filtredList)
					XCTAssertTrue(filtredList.count > 0)
					let exist = try XCTUnwrap(filtredList.first?.name?.contains("league1"))
					XCTAssertTrue(exist)
				} catch {
					XCTFail("error")
				}
				
		}).store(in: &self.subscribers)
	}
}
