
//
//  EndPointBody.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

class EndPointBody: DataConvertible {
    // MARK: - Init
    init(requestBody: [String: Any]) {
        self.requestBody = requestBody
    }
    
    init(requestData: Data) {
        self.requestData = requestData
    }
    
    // MARK: - Private
    private var requestBody: [String: Any]?
    private var requestData: Data?
}

// MARK: - DataConvertible
extension EndPointBody {
    func getData() throws -> Data {
        if let data = requestData {
            return data
        } else {
            do {
                return try JSONSerialization.data(withJSONObject: requestBody as Any, options: [])
            } catch {
                return Data()
            }
        }
    }
}
