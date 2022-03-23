//
//  Dictionary+Merge.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

extension Dictionary {
    mutating func merge(_ dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
}
