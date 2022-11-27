//
//  String+Encode.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 26/11/2022.
//

import Foundation

extension String {
	
	public var urlHost: String? {
		self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
	}
}
