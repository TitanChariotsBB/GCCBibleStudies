//
//  UserLoginView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/5/24.
//

import SwiftUI

struct UserLoginView: View {
    @EnvironmentObject var VM: ViewModel
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Login")
            TextField(text: $username) {
                Text("Username")
            }.textFieldStyle(.roundedBorder)
                .padding(5)
                .frame(width:360)
                .autocapitalization(.none)
                .autocorrectionDisabled()
            SecureField(text: $password) {
                Text("Password")
            }.textFieldStyle(.roundedBorder)
                .padding(5)
                .frame(width:360)
                .autocapitalization(.none)
                .autocorrectionDisabled()
            Button {
                VM.loginUser(username: username, password: password)
            } label: {
                Text("Login")
            }
        }
    }
    
}

#Preview {
    UserLoginView().environmentObject(ViewModel())
}
