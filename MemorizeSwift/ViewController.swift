//
//  ViewController.swift
//  MemorizeSwift
//
//  Created by Leandro Rocha on 3/16/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    let dataSource = SwiftTermsDataSource()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Swift Terms"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        dataSource.fetchData()
        tableView.dataSource = dataSource
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a Swift term"
        navigationItem.searchController = search
        definesPresentationContext = true
        
    }
    

    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.swiftTerm = dataSource.item(at: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Search controller
    func updateSearchResults(for searchController: UISearchController) {
        dataSource.filteredText = searchController.searchBar.text
    }

}

