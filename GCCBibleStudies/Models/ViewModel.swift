//
//  ViewModel.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var bibleStudies: [BibleStudy] = []
    let mm: MongoDBManager = MongoDBManager()
    
    init() {
        getBibleStudies()
    }
    
    func getBibleStudies() {
        Task {
            await mm.connect()
            let studies = await mm.getBibleStudies()
            
            await MainActor.run {
                self.bibleStudies = studies
            }
        }
    }
    
    func createNewBibleStudy(bibleStudy: BibleStudy) {
        if mm.isConnected {
            Task {
                await mm.createNewBibleStudy(bs: bibleStudy)
            }
        }
    }
}
