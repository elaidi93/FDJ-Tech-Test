//
//  LeaguesViewController.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import UIKit

class LeaguesViewController: UITableViewController {
	
	// Search Bar
	private lazy var searchControl: UISearchController = {
		let search = UISearchController(searchResultsController: nil)
		search.searchResultsUpdater = self
		search.obscuresBackgroundDuringPresentation = false
		search.searchBar.placeholder = Constants.Leagues.searchBar_placeholder
		return search
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = Constants.Leagues.title
		self.navigationController?.navigationBar.prefersLargeTitles = true
		
		self.navigationItem.searchController = self.searchControl
		
		// Permet de voir la barre de recherche à l'affichage de l'écran
		self.navigationItem.hidesSearchBarWhenScrolling = false
		
	}
}

// MARK: - TableView Protocoles

extension LeaguesViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = "ligue\(indexPath.row)"
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}


// MARK: - UISearchResultsUpdating
extension LeaguesViewController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text else { return }
		print(text)
	}
}
