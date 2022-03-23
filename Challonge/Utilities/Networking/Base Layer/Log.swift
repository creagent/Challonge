//
//  Log.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation
import os.log


extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    // MARK: - Log categories
    static let network = OSLog(subsystem: subsystem, category: "network")
    
    static let serialization = OSLog(subsystem: subsystem, category: "serialization")
    
    static let log = OSLog(subsystem: subsystem, category: "debug")
    
    // MARK: - Public
    static func fatalError(sender: Any, message: String, error: Error? = nil) {
        Swift.fatalError(debugLogString(sender: sender, message: message, error: error))
    }
    
    static func sendLog(message: String, error: Error? = nil, category: OSLog, type: OSLogType = .default, sender: Any) {
        let logString =  debugLogString(sender: sender, message: message, error: error)
#if DEBUG
        os_log("%{public}@", log: category, type: type, logString)
#else
        os_log("%{private}@", log: category, type: type, logString)
#endif
    }
    
    static func debugLogString(type: LogType = .log, sender: Any, message: String, error: Error? = nil) -> String {
        var logString = (type == .log) ? "" : "\(type.rawValue) from "
        logString += "\(String(describing: sender.self)): \((message.count == 0) ? "<empty>" : message)"
        if let error = error { logString += " [\(error)]" }
        logString += "."
        return logString
    }
    
    static func dataDebugDescription(_ data: Data) -> String {
        let result = String(data: data, encoding: .utf8) ?? debugLogString(type: .error, sender: String.self,
                                                                           message: "Failed data to UTF-8 string encoding")
        return result
    }
    
    static func requestDebugDescription(request: URLRequest,
                                        requestBody: Data? = nil,
                                        error: Error? = nil,
                                        response: URLResponse? = nil,
                                        responseData: Data? = nil) -> String {
        //Request
        var result = "\(request.httpMethod?.uppercased() ?? "<unknown>")-request to '\(request.url?.absoluteString ?? "<empty URL>")'\n"
        
        let logBody: (Data?) -> Void = { body in
            result += "Body <"
            if let body = body, body.count > 0 {
                result += "\n"
                result += "\(dataDebugDescription(body))\n"
            }
            result += ">\n"
        }
        logBody(requestBody)
        
        if let error = error {
            result += "\nError: \(error.localizedDescription)\n"
        }
        
        //Response
        if let response = response {
            result += "\n"
            if let response = response as? HTTPURLResponse {
                result += "HTTP-response with status code '\(response.statusCode)'\n"
            } else {
                result += "Response\n"
            }
            logBody(responseData)
        }
        
        return result
    }
}

enum LogType: String {
    case error
    case log
    case warning
}
