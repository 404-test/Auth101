//
//  ActivationRequest101.swift
//  AuthDev
//
//  Created by Maksim Petrenko on 10.03.2019.
//  Copyright © 2019 101 Group. All rights reserved.
//

import Foundation

public struct ActivationRequest101 {
	var email: String
	var code: String
	
	public init(email: String, code: String) {
		self.email = email
		self.code = code
	}
}

extension ActivationRequest101: Codable {
	private enum CodingKeys: String, CodingKey {
		case email
		case code = "confirmation_key"
	}
}
