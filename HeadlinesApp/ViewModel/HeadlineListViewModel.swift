//
//  HeadlineListViewModel.swift
//  HeadlinesApp
//
//  Created by Chedi Baccari on 29/08/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation

class HeadlineListViewModel {
    
    internal var headlineViewModels: [HeadlineViewModel] = [HeadlineViewModel]()
    private let webService: WebService
    private var headlineHandler: () -> () = { }
    private var selectedSource: SourceViewModel
    
    init(webService: WebService, selectedSource: SourceViewModel, completion: @escaping () -> ()) {
        self.webService = webService
        self.selectedSource = selectedSource
        self.headlineHandler = completion
        
        populateHealines()
    }
    
    func populateHealines() {
        self.webService.loadHeadLines(source: self.selectedSource.getSource(), completion: { (headlines) in
            self.headlineViewModels = headlines.map(HeadlineViewModel.init)
            self.headlineHandler()
        })
    }
    
    func itemAtIndex(index: Int) -> HeadlineViewModel {
        return self.headlineViewModels[index]
    }
}

class HeadlineViewModel {
    
    var title :String
    var description :String
    
    init(headline: Headline) {
        self.title = headline.title
        self.description = headline.description
    }
}
