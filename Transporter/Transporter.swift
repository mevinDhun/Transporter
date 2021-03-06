//
//  Transporter.swift
//  Example
//
//  Created by Le VanNghia on 3/26/15.
//  Copyright (c) 2015 Le VanNghia. All rights reserved.
//

import Foundation

// TODO
/*
- header configuration
- background event handling
*/

public struct Transporter {
    public static var headers: [String: String]?
    public static var timeoutIntervalForRequest = 60.0
    public static var timeoutIntervalForResource = 7 * 24 * 60 * 60.0
    public static var HTTPMaximumconnectionsPerHost: Int = 5
    
    fileprivate static var backgroundEventHandlers: [String: () -> ()] = [:]
    
    public static func add(_ task: TPTransferTask) -> Transaction {
        let transaction = Transaction(task: task)
        return transaction
    }
    
    public static func add(_ tasks: [TPTransferTask]) -> Transaction {
        let transaction = Transaction(tasks: tasks)
        return transaction
    }
    
    public static func add(_ taskGroup: TPTaskGroup) -> Transaction {
        let transaction = Transaction(taskGroup: taskGroup)
        return transaction
    }
}

public extension Transporter {
    static func handleEventsForBackgroundURLSection(_ identifier: String, completionHandler: @escaping () -> ()) {
        backgroundEventHandlers[identifier] = completionHandler
    }
}

internal extension Transporter {
    static func sessionDidFinishEventsForBackgroundURLSession(_ session: URLSession) {
        if let identifier = session.configuration.identifier {
            if let handler = backgroundEventHandlers[identifier] {
                handler()
                backgroundEventHandlers.removeValue(forKey: identifier)
            }
        }
    }
}
