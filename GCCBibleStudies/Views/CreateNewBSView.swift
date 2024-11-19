//
//  CreateNewBSView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import SwiftUI

struct CreateNewBSView: View {
    
    @State var name: String = ""
    @State var location: String = ""
    @State var meetingTime: String = ""
    @State var category: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create New Bible Study").font(.largeTitle).bold().padding(.bottom, 40)
            Text("Enter details below:")
            TextField(text: $name) {
                Text("Bible study name")
            }
            TextField(text: $location) {
                Text("Location on campus")
            }
            TextField(text: $meetingTime) {
                Text("Meeting time")
            }
            TextField(text: $category) {
                Text("Category")
            }
            
            HStack {
                Spacer()
                Button {
                    // onClick
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue).frame(width: 80, height: 40)
                        Text("Create").foregroundStyle(.white).bold()
                    }
                }
                
                Button {
                    // onClick
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(Color.white)
                            .frame(width: 120, height: 40)
                        Text("Save Draft").foregroundStyle(.blue).bold()
                    }
                }
            }
            Spacer()
            
        }.padding()
    }
}

#Preview {
    CreateNewBSView()
}
