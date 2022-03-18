//
//  Data+DataInstantiable.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

extension Data: DataInstantiable {
    public init(with data: Data) throws {
        self = data
    }
}
