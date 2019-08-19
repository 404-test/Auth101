//
//  Auth101.swift
//  AuthDev
//
//  Created by Maksim Petrenko on 09.03.2019.
//  Copyright © 2019 101 Group. All rights reserved.
//

import Foundation
import Alamofire

public final class Auth101 {

	public typealias RegistrationHandler101 = (_ success: Bool, _ result: RegistrationResponse101?, _ error: Error101?) -> Void
	public typealias ActivationHandler101 = (_ success: Bool, _ error: Error101?) -> Void
	public typealias ConfirmHandler101 = (_ success: Bool, _ error: Error101?) -> Void
	public typealias RestoreHandler101 = (_ success: Bool, _ error: Error101?) -> Void
	public typealias SignInHandler101 = (_ success: Bool, _ result: SignInResponse101?, _ error: Error101?) -> Void

	private var host: String!
	
	private var manager = SessionManager()

	public init(host: String) {
		// TODO: add check to correct url string and normalization for string [remove last "/"]
		self.host = host
	}

	private init() {}

	public func signUp(with registrationRequest: RegistrationRequest101, completion: RegistrationHandler101?) {

		if var url = URL(string: host) {
			url.appendPathComponent("/api/user/registration/")
			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			do {
				request.httpBody = try JSONEncoder().encode(registrationRequest)
			} catch {
				fatalError(error.localizedDescription)
			}
			
			addHeaders(to: &request)

			let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard nil == error else {
					completion?(false, nil, Error101(code: 9999, message: error!.localizedDescription))
					return
				}

				guard let response = response else {
					completion?(false, nil, Error101(code: 9999, message: "Response id nil"))
					return
				}

				guard (200...299).contains(response.getStatusCode() ?? 0) else {
					completion?(false, nil, Error101(code: response.getStatusCode() ?? 0, message: "Registration http code validation error"))
					return
				}

				if let data = data {
					do {
						let user = try JSONDecoder().decode(RegistrationResponse101.self, from: data)
						completion?(true, user, nil)
					} catch {
						completion?(false, nil, Error101(code: 9999, message: "Can't decode response"))
					}
				}
			}

			dataTask.resume()
		}
		
	}
	
	public func activate(with activationRequest: ActivationRequest101, completion: ActivationHandler101?) {
		if var url = URL(string: host) {
			url.appendPathComponent("/api/user/activate/")
			var request = URLRequest(url: url)
			request.httpMethod = "POST"

			do {
				request.httpBody = try JSONEncoder().encode(activationRequest)
			} catch {
				fatalError(error.localizedDescription)
			}

			addHeaders(to: &request)

			let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard nil == error else {
					completion?(false, Error101(code: 9999, message: error!.localizedDescription))
					return
				}

				guard let response = response else {
					completion?(false, Error101(code: 9999, message: "Response id nil"))
					return
				}

				guard (200...299).contains(response.getStatusCode() ?? 0) else {
					completion?(false, Error101(code: response.getStatusCode() ?? 0, message: "Registration http code validation error"))
					return
				}

				completion?(true, nil)
			}

			dataTask.resume()
		}
	}
	
	public func signIn(with signInRequest: SignInRequest101, completion: SignInHandler101?) {
		if var url = URL(string: host) {
			url.appendPathComponent("/api/user/login/")
			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			do {
				request.httpBody = try JSONEncoder().encode(signInRequest)
			} catch {
				fatalError(error.localizedDescription)
			}

			addHeaders(to: &request)

			manager.request(request)
				.validate()
				.responseData { responseData in
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .secondsSince1970
					
					switch responseData.result {
					case .success(let data):
						do {
							let validResponse = try JSONDecoder().decode(SignInResponse101.self, from: data)
							completion?(true, validResponse, nil)
						} catch {
							completion?(false, nil, Error101(code: 9999, message: "Can't decode response"))
						}
					case .failure(let error):
						completion?(false, nil, Error101(code: 9999, message: error.localizedDescription))
						return
					}
			}
			
//			let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//				guard nil == error else {
//					completion?(false, nil, Error101(code: 9999, message: error!.localizedDescription))
//					return
//				}
//
//				guard let response = response else {
//					completion?(false, nil, Error101(code: 9999, message: "Response id nil"))
//					return
//				}
//
//				guard (200...299).contains(response.getStatusCode() ?? 0) else {
//					completion?(false, nil, Error101(code: response.getStatusCode() ?? 0, message: "SignIn http code validation error"))
//					return
//				}
//
//				if let data = data {
//					do {
//						let validResponse = try JSONDecoder().decode(SignInResponse101.self, from: data)
//						completion?(true, validResponse, nil)
//					} catch {
//						completion?(false, nil, Error101(code: 9999, message: "Can't decode response"))
//					}
//				}
//			}
//
//			dataTask.resume()
		}
	}
	
	
	public func confirm(with confirmRequest: ConfirmRequest101, completion: ConfirmHandler101?) {
		if var url = URL(string: host) {
			url.appendPathComponent("/api/user/password-recovery/")
			var request = URLRequest(url: url)
			request.httpMethod = "PUT"
			do {
				request.httpBody = try JSONEncoder().encode(confirmRequest)
			} catch {
				fatalError(error.localizedDescription)
			}
			
			addHeaders(to: &request)
			
			let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard nil == error else {
					completion?(false, Error101(code: 9999, message: error!.localizedDescription))
					return
				}
				
				guard let response = response else {
					completion?(false, Error101(code: 9999, message: "Response id nil"))
					return
				}
				
				guard (200...299).contains(response.getStatusCode() ?? 0) else {
					completion?(false, Error101(code: response.getStatusCode() ?? 0, message: "SignIn http code validation error"))
					return
				}

				completion?(true, nil)
			}
			
			dataTask.resume()
		}
	}
	
	public func restore(with restoreRequest: RestoreRequest101, completion: RestoreHandler101?) {
		var url = URL(string: host)
		
		if nil == restoreRequest.code && nil == restoreRequest.password {
			url = getUrlForGET(from: host, with: ["email": restoreRequest.email])
		}
		url?.appendPathComponent("/api/user/password-recovery/")
		if let url = url {
			var request = URLRequest(url: url)
			if nil != restoreRequest.code {
				request.httpMethod = "PUT"
			} else if (nil != restoreRequest.code && nil != restoreRequest.password) {
				request.httpMethod = "POST"
			}
			if request.httpMethod != "GET" {
				do {
					request.httpBody = try JSONEncoder().encode(restoreRequest)
				} catch {
					fatalError(error.localizedDescription)
				}
			}
			
			addHeaders(to: &request)
			
			let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard nil == error else {
					completion?(false, Error101(code: 9999, message: error!.localizedDescription))
					return
				}
				
				guard let response = response else {
					completion?(false, Error101(code: 9999, message: "Response id nil"))
					return
				}
				
				guard (200...299).contains(response.getStatusCode() ?? 0) else {
					completion?(false, Error101(code: response.getStatusCode() ?? 0, message: "SignIn http code validation error"))
					return
				}
				
				completion?(true, nil)
			}
			
			dataTask.resume()
		}
	}
		
	func getUrlForGET(from urlString: String, with params: [String: String]) -> URL? {
		if var components = URLComponents(string: urlString) {
			components.queryItems = params.compactMap {
				URLQueryItem(name: $0.0, value: $0.1)
			}
			
			return components.url
		}
		
		return nil
	}
	
	func addHeaders(to request: inout URLRequest) {
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
//		request.addValue(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "", forHTTPHeaderField: "X-App-Version")
		request.addValue("ios", forHTTPHeaderField: "X-App-Type")
	}
	
	func buildQueryString(fromDictionary parameters: [String: String]) -> String {
		var urlVars:[String] = []
		
		for (k,value) in parameters {
			if let encodedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
				urlVars.append(k + "=" + encodedValue)
			}
		}
		
		return urlVars.isEmpty ? "" : "?" + urlVars.joined(separator: "&")
	}
}
