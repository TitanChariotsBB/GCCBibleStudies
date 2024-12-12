//
//  CreateNewAccount.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/5/24.
//

import SwiftUI

struct CreateNewAccount: View {
    
    @AppStorage("needsAccount") var needsAccount: Bool?
    
    @EnvironmentObject var VM: ViewModel
    
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var fname: String = ""
    @State var lname: String = ""
    
    var passwordsMatch: Bool { password == confirmPassword }
    
    var body: some View {
        VStack {
            Text("Welcome to GCC Bible Studies!")
            Text("Create an account")
            TextField(text: $username) {
                Text("New username")
            }.textFieldStyle(.roundedBorder)
                .padding(5)
                .frame(width:360)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .textContentType(.username)
            SecureField(text: $password) {
                Text("New password")
            }.textFieldStyle(.roundedBorder)
                .padding(5)
                .frame(width:360)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .textContentType(.newPassword)
            SecureField(text: $confirmPassword) {
                Text("Confirm password")
            }.textFieldStyle(.roundedBorder)
                .padding(5)
                .frame(width:360)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .textContentType(.password)
            TextField(text: $fname) {
                Text("First name")
            }.textFieldStyle(.roundedBorder)
                .padding(5)
                .frame(width:360)
                .autocorrectionDisabled()
            TextField(text: $lname) {
                Text("Last name")
            }.textFieldStyle(.roundedBorder)
                .padding(5)
                .frame(width:360)
                .autocorrectionDisabled()
            Button {
                VM.createNewUser(username: username, password: password, fname: fname, lname: lname)
                
                needsAccount = false
                
            } label: {
                Text("Create account")
            }.disabled(!passwordsMatch)
        }.padding(20)
    }
}

#Preview {
    CreateNewAccount().environmentObject(ViewModel())
}
