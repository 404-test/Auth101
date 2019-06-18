//
//  ConfirmRequest101.swift
//  Auth101
//
//  Created by Maxim Petrenko on 18.06.2019.
//

import Foundation

public struct ConfirmRequest101 {
	var email: String
	var code: String
	
	public init(email: String, code: String) {
		self.email = email
		self.code = code
	}
}

extension ConfirmRequest101: Codable {
	private enum CodingKeys: String, CodingKey {
		case email
		case code = "confirmation_key"
	}
}
