//
//  SwiftTermsDataSource.swift
//  MemorizeSwift
//
//  Created by Leandro Rocha on 3/16/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class SwiftTermsDataSource: NSObject, UITableViewDataSource {
    
    var swiftTerms = [SwiftTerm]()
    var filteredSwiftTerms = [SwiftTerm]()
    var dataChanged: (() -> Void)?
    
    var filteredText: String? {
        didSet {
            filteredSwiftTerms = swiftTerms.matching(filteredText)
            dataChanged?()
        }
    }
    
    // MARK: - Methods
    func item(at index: Int) -> SwiftTerm {
        return filteredSwiftTerms[index]
    }
    
    func fetchData() {
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
        filteredSwiftTerms = terms
        
        self.dataChanged?()
    }
    
    // MARK: - Table view data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSwiftTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Term", for: indexPath)
        cell.textLabel?.text = filteredSwiftTerms[indexPath.row].term
        return cell
    }
}
