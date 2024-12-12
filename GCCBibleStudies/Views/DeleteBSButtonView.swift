//
//  DeleteBSButtonView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/11/24.
//

import SwiftUI

struct DeleteBSButtonView: View {
    
    @EnvironmentObject var VM: ViewModel
    
    var bs: BibleStudy
    
    @Binding var isShowingDialog: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    isShowingDialog = true
                } label: {
                    Image(systemName: "trash").resizable().frame(width: 30, height: 30).foregroundStyle(.red).padding(40)
                }
            }
        }
    }
}
