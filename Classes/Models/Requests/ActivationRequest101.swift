//
//  ActivationRequest101.swift
//  AuthDev
//
//  Created by Maksim Petrenko on 10.03.2019.
//  Copyright © 2019 101 Group. All rights reserved.
//

import Foundation

struct ActivationRequest101 {
	var email: String
	var code: String
}

extension ActivationRequest101: Codable {
	private enum CodingKeys: String, CodingKey {
		case email
		case code = "confirmation_key"
	}
}
