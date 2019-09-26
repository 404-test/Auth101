//
//  Error101.swift
//  Auth101
//
//  Created by Maxim Petrenko on 19.08.2019.
//

import Foundation

public struct Error101 {
	public private(set) var code: Int
	public private(set) var message: String
	
	init(code: Int, message: String) {
		self.code = code
		self.message = message
	}
}

extension Error101: Codable {
	
}

extension Error101: Error {}
