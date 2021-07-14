//
//  LoginView.swift
//  UITestingDemo
//
//  Created by Ryan Schefske on 7/13/21.
//

import SwiftUI

struct LoginView: View {
	@EnvironmentObject private var user: User
	@Environment(\.presentationMode) var presentationMode
	@State private var showAlert = false
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Username", text: $user.username)
					SecureField("Password", text: $user.password)
				}

				Button("Login") {
					if user.login() {
						presentationMode.wrappedValue.dismiss()
					} else {
						showAlert = true
					}
				}
				.accessibilityIdentifier("loginNow")
			}
			.navigationTitle("Login")
			.navigationBarItems(
				trailing:
					Button {
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "xmark.circle")
							.accessibilityIdentifier("Dismiss")
					}
			)
			.alert(isPresented: $showAlert) {
				Alert(title: Text("LoginFailed"), message: Text("Either username or password is missing."), dismissButton: .default(Text("OK"), action: {
					showAlert = false
				}))
			}
		}
	}
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
