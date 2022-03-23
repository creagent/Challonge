//
//  DataInstantiable.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

protocol DataInstantiable {
    init(with data: Data) throws
}
