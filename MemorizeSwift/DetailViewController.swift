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
    var blankCounter = 0

    let visibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 24)!,
        .foregroundColor: UIColor.black
    ]
    
    let invisibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 24)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle: 1,
        .strikethroughColor: UIColor.black
    ]
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = swiftTerm.term
        navigationItem.largeTitleDisplayMode = .never

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOccurred))
        textView.addGestureRecognizer(tapRecognizer)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeOccurred))
        swipeRecognizer.direction = .down
        textView.addGestureRecognizer(swipeRecognizer)
        
        textView.attributedText = showText(for: swiftTerm)
    }
    
    func showText(for swiftTerm: SwiftTerm, fullyVisible: Bool = false) -> NSAttributedString {
        if fullyVisible {
            return NSAttributedString(string: swiftTerm.description, attributes: visibleText)
        }
        
        let words = swiftTerm.description.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        
        let space = NSAttributedString(string: " ", attributes: visibleText)
        
        for (index, word) in words.enumerated() {
            if index < blankCounter {
                let attributedWord = NSAttributedString(string: word, attributes: visibleText)
                output.append(attributedWord)
            } else {
                var strippedWord = word
                var punctuation: String?
                
                if ",.".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                let attributedWord = NSAttributedString(string: "\(word)", attributes: invisibleText)
                output.append(attributedWord)
                
                if let symbol = punctuation {
                    let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleText)
                    output.append(attributedPunctuation)
                }
            }
            
            output.append(space)
        }
        
        return output
    }
    
    @objc func tapOccurred() {
        blankCounter += 1
        textView.attributedText = showText(for: swiftTerm)
    }
    
    @objc func swipeOccurred() {
        textView.attributedText = showText(for: swiftTerm, fullyVisible: true)
    }

}
