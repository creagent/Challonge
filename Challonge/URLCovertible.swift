//
//  URLCovertible.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

public protocol URLConvertible {
    func getURL() throws -> URL
}
