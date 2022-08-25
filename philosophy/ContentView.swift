//
//  ContentView.swift
//  philosophy
//
//  Created by 市川マサル on 2022/08/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signInWithAppleObject = SignInWithAppleObject()
    var body: some View {
        
        VStack {
            TextField("E-mail", text: self.$email)
            TextField("Password", text: self.$password)
            
                   Button(action: {
                       signInWithAppleObject.signInWithApple()
                   }, label: {
                       SignInWithAppleButton()
                           .frame(height: 50)
                           .cornerRadius(16)
                   })
                   .padding()
               }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


