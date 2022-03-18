//
//  Serializer.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

class Serializer {
    func serialize<Y: Decodable>(type: Y.Type, from data: Data?) throws -> Y? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(type, from: data)
            return result
        }
    }
}
