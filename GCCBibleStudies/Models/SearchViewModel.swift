//
//  SearchViewModel.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 12/9/24.
//

import Foundation
import Combine

@MainActor
class SearchViewModel:ObservableObject {
    @Published var searchtext:String = ""
    @Published var biblestudies = []
    @Published var filteredBibleStudies = []
    @Published var viewmodel:ViewModel
    var cancellables = Set<AnyCancellable>()
    
    init(viewmodel:ViewModel) {
        self.viewmodel = viewmodel
        biblestudies = viewmodel.bibleStudies
    }
    
    // add subscribers to the search text
    func addsubscribers() {
        // access the published value of the search text so that everytime the text changes
        // this text changes as well
        // debounce makes it so that we just perform an action if the user has stopped typing
        // for at least 0.3 seconds
        $searchtext
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { searchtext in
                self.filterBibleStudies(searchtext: searchtext)
            }
        
    }
    
    private func filterBibleStudies(searchtext:String) {
        
    }
}
