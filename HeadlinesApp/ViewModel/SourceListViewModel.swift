//
//  SourceListViewModel.swift
//  HeadlinesApp
//
//  Created by Chedi Baccari on 29/08/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation

class SourceListViewModel {
    
    internal var sourceViewModels: [SourceViewModel] = [SourceViewModel]()
    private var webService: WebService!
    private var sourcesHandler: () -> () = {}
    
    init(webService: WebService, completion: @escaping () -> ()) {
        self.webService = webService
        self.sourcesHandler = completion
        populateSource()
    }
    
    private func populateSource() {
        self.webService.loadSources { (sources) in
            self.sourceViewModels = sources.map(SourceViewModel.init)
            self.sourcesHandler()
        }
    }
    
    func itemAtIndex(index: Int) -> SourceViewModel {
        return self.sourceViewModels[index]
    }
}

class SourceViewModel {
    var id :String
    var name :String
    var description :String
    
    init(source: Source) {
        self.id = source.id
        self.name = source.name
        self.description = source.description
    }
    
    func getSource() -> Source {
        return Source(id: self.id, name: self.name, description: self.description)
    }
}
