//
//  Dictionary+DataInstantiable.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation
import os.log

extension Dictionary: DataInstantiable where Key == String, Value: AnyObject {
    public init(with data: Data) throws {
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Self.Value] else {
            let message = "Failed to init a dictionary '\(String(describing: Self.self))' from JSON-data <\(OSLog.dataDebugDescription(data))>"
            OSLog.sendLog(message: message, error: nil, category: .serialization, type: .error, sender: JSONSerialization.self)
            throw NSError.init()
        }
        self = jsonDictionary
    }
}
