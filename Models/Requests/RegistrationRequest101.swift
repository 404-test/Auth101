//
//  RegistrationRequest101.swift
//  AuthDev
//
//  Created by Maksim Petrenko on 09.03.2019.
//  Copyright © 2019 101 Group. All rights reserved.
//

import Foundation

struct RegistrationRequest101 {
	var email: String
	var phoneNumber: String
	var password: String
	var userName: String
	
	init(email: String, phoneNumber: String, userName: String, password: String) {
		self.email = email
		self.phoneNumber = phoneNumber
		self.password = password
		self.userName = userName
	}
}

extension RegistrationRequest101: Codable {
	private enum CodingKeys: String, CodingKey {
		case email, password
		case phoneNumber = "phone_number"
		case userName = "user_title"
	}
}
