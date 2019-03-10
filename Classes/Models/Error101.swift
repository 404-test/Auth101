//
//  Error101.swift
//  AuthDev
//
//  Created by Maksim Petrenko on 09.03.2019.
//  Copyright © 2019 101 Group. All rights reserved.
//

import Foundation

public struct Error101 {
	var code: Int
	var message: String
	
	init(code: Int, message: String) {
		self.code = code
		self.message = message
	}
}

extension Error101: Codable {
	
}

extension Error101: Error {}
