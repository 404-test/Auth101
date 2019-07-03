//
//  RestoreRequest101.swift
//  Auth101
//
//  Created by Maxim Petrenko on 18.06.2019.
//

import Foundation

public struct RestoreRequest101 {
	public private(set) var email: String
	public private(set) var code: Int?
	public private(set) var password: String?
	
	public init(email: String, code: Int?, password: String?) {
		self.email = email
		self.code = code
		self.password = password
	}
	
	public mutating func set(email: String) {
		self.email = email
	}
	
	public mutating func set(code: Int) {
		self.code = code
	}
	
	public mutating func set(password: String) {
		self.password = password
	}
}

extension RestoreRequest101: Codable {
	private enum CodingKeys: String, CodingKey {
		case email, password
		case code = "confirmation_key"
	}
}
