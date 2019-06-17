//
//  SignInResponse101.swift
//  Auth101
//
//  Created by Maxim Petrenko on 17.06.2019.
//

import Foundation

public struct SignInResponse101 {
	public var token: String
}

extension SignInResponse101: Codable {
	private enum CodingKeys: String, CodingKey {
		case token
	}
}
