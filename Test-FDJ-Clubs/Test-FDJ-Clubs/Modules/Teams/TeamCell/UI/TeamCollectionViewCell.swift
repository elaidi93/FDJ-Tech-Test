//
//  TeamCollectionViewCell.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 26/11/2022.
//

import UIKit
import Combine

class TeamCollectionViewCell: UICollectionViewCell, ReuseIdentifierProtocol {
    
	private var subscribers = Set<AnyCancellable>()
	
	private lazy var imageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.adjustsImageSizeForAccessibilityContentSizeCategory = false
		imageView.frame = contentView.frame
		imageView.contentMode = .scaleAspectFit
		contentView.addSubview(imageView)
		return imageView
	}()
	
	func configure(with team: Team, viewModel: TeamCellViewModel) {
		viewModel.loadImage(from: team)
		viewModel.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { [weak self] _ in
				self?.imageView.image = viewModel.image
		}).store(in: &self.subscribers)
	}
	
	override func prepareForReuse() {
		imageView.image = nil
	}
}
