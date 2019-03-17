//
//  ViewController.swift
//  MemorizeSwift
//
//  Created by Leandro Rocha on 3/16/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var swiftTerms = [SwiftTerm]()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Swift Terms"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let url = Bundle.main.url(forResource: "SwiftTerms", withExtension: ".json") else {
            fatalError("Unable to locate SwiftTerms.json")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load contents of SwiftTerms.json")
        }
        
        let decoder = JSONDecoder()
        
        guard let terms = try? decoder.decode([SwiftTerm].self, from: data) else {
            fatalError("Unable to decode SwiftTerms.json")
        }
        
        swiftTerms = terms
    }
    
    //MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftTerms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Term", for: indexPath)
        cell.textLabel?.text = swiftTerms[indexPath.row].term
        return cell
    }

    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.swiftTerm = swiftTerms[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

