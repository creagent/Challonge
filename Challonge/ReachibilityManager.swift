//
//  ReachibilityManager.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation
import Reachability

public class ReachabilityManager {
    public static var isNetworkConnected: Bool {
        guard let r = try? Reachability() else { return false }
        return r.connection != .unavailable
    }
}
