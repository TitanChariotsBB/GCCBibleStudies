//
//  ViewModel.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var bibleStudies: [BibleStudy] = []
    
    init() {
        createDummyData()
    }
    
    func createDummyData() {
        bibleStudies.append(BibleStudy(title: "Prayer Group", location: "Stem 376", description: "Test Description", category: "Men's", time: Date(), day: "Monday"))
        
        bibleStudies.append(BibleStudy(title: "Romans Bible Study", location: "HAL 216", description: "Test Description 2", category: "All", time: Date(), day: "Tuesday"))
        
        bibleStudies.append(BibleStudy(title: "Joel", location: "Hopeman 226", description: "Test Description 2", category: "Men's", time: Date(), day: "Tuesday"))
    }
}
