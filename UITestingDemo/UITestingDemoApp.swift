//
//  UITestingDemoApp.swift
//  UITestingDemo
//
//  Created by Ryan Schefske on 7/13/21.
//

import SwiftUI

@main
struct UITestingDemoApp: App {
	var user = User()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(user)
        }
    }
}
