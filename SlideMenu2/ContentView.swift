//
//  ContentView.swift
//  SlideMenu2
//
//  Created by Mher Melkonyan on 10/26/21.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isLoginValid: Bool = false
    @State private var shouldShowLoginAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
                    .font(.system(size: 32, design: .rounded))
                    .bold()
                    .foregroundColor(.black)
                    .padding()
                Image("app_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .font(.system(size: 16, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 320, height: 40)
                    .background(Color.loginPageColor)
                    .cornerRadius(13.0)
                    .padding(.top, 20)
                SecureField("Password", text: $password)
                    .font(.system(size: 16, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 320, height: 40)
                    .background(Color.loginPageColor)
                    .cornerRadius(13.0)
                    .padding(.top, 10)
                Button(action: {
                    self.isLoginValid = self.email == LoginInfo.email && self.password == LoginInfo.password
                    if !isLoginValid {
                        self.shouldShowLoginAlert = true
                    }
                }, label: {
                    Text("LOGIN")
                        .font(.system(size: 20, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                })
                .frame(width: 130, height: 40, alignment: .center)
                .background(Color.blue)
                .cornerRadius(13.0)
                .padding(.top, 20)
                .fullScreenCover(isPresented: $isLoginValid, content: StartView.init)
                .alert(isPresented: $shouldShowLoginAlert) {
                    Alert(
                        title: Text("Email or Password is incorrect"),
                        message: Text("Try again"),
                        dismissButton: .default(Text("Got it!"))
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


