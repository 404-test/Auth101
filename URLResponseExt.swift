//
//  URLResponseExt.swift
//  AuthDev
//
//  Created by Maksim Petrenko on 09.03.2019.
//  Copyright © 2019 101 Group. All rights reserved.
//

import Foundation

extension URLResponse {
	
	func getStatusCode() -> Int? {
		if let httpResponse = self as? HTTPURLResponse {
			return httpResponse.statusCode
		}
		return nil
	}
}
