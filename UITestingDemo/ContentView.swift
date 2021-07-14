//
//  ContentView.swift
//  UITestingDemo
//
//  Created by Ryan Schefske on 7/13/21.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var user: User
	@State private var showLogin = false
	
    var body: some View {
		VStack {
			Text(user.isLoggedIn ? "Welcome, \(user.username)!" : "Welcome!")
				.font(.title)
			
			Button(user.isLoggedIn ? "Logout" : "Login") {
				if user.isLoggedIn {
					user.logout()
				} else {
					showLogin = true
				}
			}
			.accessibilityIdentifier("loginButton")
		}
		.sheet(isPresented: $showLogin) {
			LoginView()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
