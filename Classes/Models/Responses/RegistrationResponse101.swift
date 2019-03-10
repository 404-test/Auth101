//
//  RegistrationResponse101.swift
//  AuthDev
//
//  Created by Maksim Petrenko on 10.03.2019.
//  Copyright © 2019 101 Group. All rights reserved.
//

import Foundation

struct RegistrationResponse101 {
	var id: Int
	var email: String
	var userName: String
	var phoneNumber: String
}

extension RegistrationResponse101: Codable {
	private enum CodingKeys: String, CodingKey {
		case id, email
		case phoneNumber = "phone_number"
		case userName = "user_title"
	}
}
