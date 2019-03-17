//
//  SwiftTerm.swift
//  MemorizeSwift
//
//  Created by Leandro Rocha on 3/16/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import Foundation

struct SwiftTerm: Decodable {
    var term: String
    var description: String
}

extension Array where Element == SwiftTerm {
    func matching(_ text: String?) -> [SwiftTerm] {
        if let text = text, text.count > 0 {
            let lowercasedText = text.lowercased()
            return self.filter {
                $0.term.lowercased().contains(lowercasedText)
                    || $0.description.lowercased().contains(lowercasedText)
            }
        } else {
            return self
        }
    }
}
