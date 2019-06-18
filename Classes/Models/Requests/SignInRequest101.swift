//
//  SignInRequest101.swift
//  Auth101
//
//  Created by Maxim Petrenko on 13.06.2019.
//

import Foundation

public struct SignInRequest101 {
	var email: String
	var password: String
	
	public init(email: String, password: String) {
		self.email = email
		self.password = password
	}
}

extension SignInRequest101: Codable {
	private enum CodingKeys: String, CodingKey {
		case email, password
	}
}
