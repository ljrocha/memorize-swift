//
//  DetailViewController.swift
//  MemorizeSwift
//
//  Created by Leandro Rocha on 3/16/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    var swiftTerm: SwiftTerm!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = swiftTerm.term
        navigationItem.largeTitleDisplayMode = .never
        
        textView.text = swiftTerm.description

    }

}
