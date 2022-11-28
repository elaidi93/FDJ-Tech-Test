//
//  LeaguesViewController.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import UIKit
import Combine

class LeaguesViewController: UITableViewController {
	
	// Search Bar
	private lazy var searchControl: UISearchController = {
		let search = UISearchController(searchResultsController: nil)
		search.searchResultsUpdater = self
		search.obscuresBackgroundDuringPresentation = false
		search.searchBar.placeholder = Constants.Leagues.searchBar_placeholder
		return search
	}()
	
	private let viewModel: LeaguesViewModel?
	private var subscribers = Set<AnyCancellable>()
	
	init(viewModel: LeaguesViewModel) {
		self.viewModel = viewModel
		self.viewModel?.getLeagues()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("Not supported!")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = Constants.Leagues.title
		self.navigationController?.navigationBar.prefersLargeTitles = true
		
		self.navigationItem.searchController = self.searchControl
		
		// Permet de voir la barre de recherche à l'affichage de l'écran
		self.navigationItem.hidesSearchBarWhenScrolling = false
		
		// Object Listner
		self.viewModel?.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { [weak self] _ in
			self?.tableView.reloadData()
		}).store(in: &self.subscribers)
	}
}

// MARK: - TableView Protocoles

extension LeaguesViewController {
	
	override func tableView(_ tableView: UITableView,
							numberOfRowsInSection section: Int) -> Int {
		return self.viewModel?.filtredList?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView,
							cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = self.viewModel?.filtredList?[indexPath.row].name
		return cell
	}
	
	override func tableView(_ tableView: UITableView,
							didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let league = self.viewModel?.filtredList?[indexPath.row]
		else { return }
		
		let teamsVC = TeamsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
		teamsVC.league = league
		self.navigationController?.pushViewController(teamsVC,
													  animated: true)
	}
}


// MARK: - UISearchResultsUpdating
extension LeaguesViewController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text
		else { return }
		self.viewModel?.filterList(with: text)
	}
}
