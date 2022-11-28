//
//  UIView+ReuseIdentifier.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 25/11/2022.
//

import Foundation

import Foundation

protocol ReuseIdentifierProtocol {
	static var reuseIdentifier: String { get }
}

extension ReuseIdentifierProtocol {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
		}
}
