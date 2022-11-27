//
//  TeamsCollectionViewController.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 26/11/2022.
//

import UIKit
import Combine

class TeamsCollectionViewController: UICollectionViewController {
	
	var league: League?
	private var viewModel: TeamViewModel = TeamViewModel(manager: RequestManager())
	private var subscribers = Set<AnyCancellable>()
	
	private let itemsPerRow: CGFloat = 2
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.collectionView.register(TeamCollectionViewCell.self,
									 forCellWithReuseIdentifier: TeamCollectionViewCell.reuseIdentifier)
		
		self.title = Constants.Teams.title
		
		fetchTeams()
	}
	
	private func fetchTeams() {
		if let league {
			self.viewModel.fetchTeams(from: league)
			
			// Object Listner
			self.viewModel.objectWillChange
				.receive(on: DispatchQueue.main)
				.sink(receiveValue: { [weak self] _ in
					self?.collectionView.reloadData()
				}).store(in: &self.subscribers)
		}
	}
}

// MARK: UICollectionViewDataSource

extension TeamsCollectionViewController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.teams?.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let team = self.viewModel.teams?[indexPath.row],
			  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.reuseIdentifier, for: indexPath) as? TeamCollectionViewCell
		else { return UICollectionViewCell() }
		
		cell.configure(with: team,
					   viewModel: TeamCellViewModel(manager: RequestManager()))
		
		return cell
	}
}

extension TeamsCollectionViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let paddingSpace = 20 * (itemsPerRow + 1)
		let availableWidth = view.frame.width - paddingSpace
		let widthPerItem = availableWidth / itemsPerRow
		
		return CGSize(width: widthPerItem, height: widthPerItem)
	}
}
