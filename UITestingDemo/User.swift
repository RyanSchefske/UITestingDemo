//
//  User.swift
//  UITestingDemo
//
//  Created by Ryan Schefske on 7/13/21.
//

import Combine
import Foundation

class User: ObservableObject {
	@Published var isLoggedIn = false
	@Published var username = ""
	@Published var password = ""
	
	func login() -> Bool {
		guard username == "test" && password == "pass" else {
			return false
		}
		
		password = ""
		isLoggedIn = true
		return true
	}
	
	func logout() {
		isLoggedIn = false
		username = ""
	}
}
