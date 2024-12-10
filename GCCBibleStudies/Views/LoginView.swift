//
//  LoginView.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 11/19/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var username:String = ""
    @State var password:String = ""
    @State var pwdsecured:Bool = true
    @State var displayerrormessage:Bool = false
    var errormessage:String = "incorrect username or password"
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Spacer()
                
                TextField("Username",text:$username)
                    .textFieldStyle(.roundedBorder)
                    .padding(5)
                    .frame(width:360)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                HStack {
                    if pwdsecured {
                        SecureField("Password (at least 8 characters)",text:$password)
                            .textFieldStyle(.roundedBorder)
                            .frame(width:350)
                            .padding(5)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        Button {
                            pwdsecured = !pwdsecured
                        } label: {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.gray)
                        }.padding(.trailing,5)
                    }
                    else {
                        TextField("Password (at least 8 characters)",text:$password)
                            .textFieldStyle(.roundedBorder)
                            .frame(width:350)
                            .padding(5)
                            .padding(.vertical,1.6)
                        Button {
                            pwdsecured = !pwdsecured
                        } label: {
                            Image(systemName: "eye")
                                .foregroundColor(.gray)
                        }.padding(.trailing,5)
                    }
                }
                
                if username.count == 0 && password.count == 0 && displayerrormessage {
                    Text(errormessage)
                        .padding(.horizontal,5)
                        .foregroundColor(Color(red:150/255,green:150/255,blue:150/255))
                }
                else {
                    Text("text").hidden()
                }
                
                if username != "" && password.count >= 8 {
                    
                    NavigationLink {
                        //right now there are 2 valid logins
//                        if (username == "christianabbott" && password == "password1") || (username == "natekuhns" && password == "password9"){MainView().navigationBarBackButtonHidden(true)}
//                        else {
//                            LoginView(displayerrormessage: true).navigationBarBackButtonHidden(true)
//                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width:100,height:50)
                                .padding(.horizontal,5)
                                .padding(.vertical)
                            Text("Login")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    
                }
                
                else {
                    // hidden button to keep the fields in place
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:100,height:50)
                            .padding(.horizontal,5)
                            .padding(.vertical)
                        Text("Login")
                            .foregroundColor(.white)
                            .bold()
                    }.hidden()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView().environmentObject(ViewModel())
}
