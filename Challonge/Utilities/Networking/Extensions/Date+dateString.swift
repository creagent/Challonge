//
//  Date+dateString.swift
//  Challonge
//
//  Created by Антон Алексеев on 17.04.2022.
//

import Foundation

extension Date {
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
