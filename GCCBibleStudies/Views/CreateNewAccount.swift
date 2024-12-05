//
//  CreateNewAccount.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/5/24.
//

import SwiftUI

struct CreateNewAccount: View {
    
    @EnvironmentObject var VM: ViewModel
    
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var fname: String = ""
    @State var lname: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome to GCC Bible Studies!")
            Text("Create an account")
            TextField(text: $username) {
                Text("New username")
            }
            TextField(text: $password) {
                Text("New password")
            }
            TextField(text: $confirmPassword) {
                Text("Confirm password")
            }
            TextField(text: $fname) {
                Text("First name")
            }
            TextField(text: $lname) {
                Text("Last name")
            }
            Button {
                VM.createNewUser(username: username, password: password, fname: fname, lname: lname)
            } label: {
                Text("Create account")
            }
        }
    }
}

#Preview {
    CreateNewAccount().environmentObject(ViewModel())
}
