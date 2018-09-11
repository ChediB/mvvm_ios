//
//  HeadlinesTableViewController.swift
//  HeadlinesApp
//
//  Created by Chedi Baccari on 29/08/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import UIKit

class HeadlinesTableViewController : UITableViewController {
    
    private var headlineListViewModels :HeadlineListViewModel!
    private var headlinesDataSource: TableViewDataSource<HeadlineTableViewCell, HeadlineViewModel>!
    
    var source :SourceViewModel! {
        didSet {
            self.headlineListViewModels = HeadlineListViewModel(webService: WebService(), selectedSource: self.source, completion: {
                self.title = self.source.name
                self.setUpCells()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setUpCells() {
        
        self.headlinesDataSource = TableViewDataSource(cellIdentifier: "Cell", items: self.headlineListViewModels.headlineViewModels, configureCell: { (cell, item) in
            
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            
        })
        
        self.tableView.dataSource = self.headlinesDataSource
        self.tableView.reloadData()
    }
}
