//
//  SourcesTableViewController.swift
//  HeadlinesApp
//
//  Created by Chedi Baccari on 29/08/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import UIKit

class SourcesTableViewController : UITableViewController {
    
    private var sourceListViewModel: SourceListViewModel!
    private var dataSource: TableViewDataSource<SourceTableViewCell, SourceViewModel>!
    private let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.startLoading()
        
        self.sourceListViewModel = SourceListViewModel(webService: WebService(), completion: {
            
            self.dataSource = TableViewDataSource(cellIdentifier: "Cell", items: self.sourceListViewModel.sourceViewModels) {
                (cell, sourceViewModel) in
                cell.titleLabel.text = sourceViewModel.name
                cell.descriptionLabel.text = sourceViewModel.description
            }
            
            self.tableView.dataSource = self.dataSource
            self.stopLoading()
            self.tableView.reloadData()
        })
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let headlinesTVC = segue.destination as? HeadlinesTableViewController else {
            fatalError("HeadlinesTableViewController not found")
        }
        
        let indexPath = (self.tableView.indexPathForSelectedRow)!
        let source = self.sourceListViewModel.itemAtIndex(index: indexPath.row)
        
        headlinesTVC.source = source
        
    }
   
}

extension SourcesTableViewController {
    
    func startLoading(){
        self.tableView.separatorStyle = .none
        activityIndicator.center = self.tableView.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        self.tableView.addSubview(activityIndicator);
        
        activityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
        
    }
    
    func stopLoading(){
        self.tableView.separatorStyle = .singleLine
        activityIndicator.stopAnimating();
        UIApplication.shared.endIgnoringInteractionEvents();
        
    }
}







