//
//  TPCommon.swift
//  Example
//
//  Created by Le VanNghia on 3/26/15.
//  Copyright (c) 2015 Le VanNghia. All rights reserved.
//

import Foundation

// TODO
/*
- completionHander
    - uploading
    - downloading
    - group
*/

public enum TPMethod : String {
    case GET    = "GET"
    case POST   = "POST"
    case PUT    = "PUT"
}

public typealias ProgressHandler = (_ completedBytes: Int64, _ totalBytes: Int64) -> ()
public typealias CompletionHandler = (_ tasks: [TPTransferTask]) -> ()
public typealias TransferCompletionHandler = (_ response: HTTPURLResponse?, _ json: String?, _ error: NSError?) -> ()

infix operator --> { associativity left precedence 160 }

public func --> (left: TPTransferTask, right: TPTransferTask) -> TPTaskGroup {
    return TPTaskGroup(left: left, right: right, mode: .serialization)
}

public func --> (left: TPTaskGroup, right: TPTransferTask) -> TPTaskGroup {
    return left.append(right)
}

infix operator ||| { associativity left precedence 160 }

public func ||| (left: TPTransferTask, right: TPTransferTask) -> TPTaskGroup {
    return TPTaskGroup(left: left, right: right, mode: .concurrency)
}

public func ||| (left: TPTaskGroup, right: TPTransferTask) -> TPTaskGroup {
    return left.append(right)
}

// http boby builder
func queryStringFromParams(_ params: [String: AnyObject]) -> String {
    let paramsArray = convertParamsToArray(params)
    let queryString = paramsArray.map{ "\($0)=\($1)" }.joined(separator: "&")
    
    return queryString.addingPercentEscapes(using: String.Encoding.utf8)!
}

func convertParamsToArray(_ params: [String: AnyObject]) -> [(String, AnyObject)] {
    var result = [(String, AnyObject)]()
    
    for (key, value) in params {
        if let arrayValue = value as? NSArray {
            for nestedValue in arrayValue {
                let dic = ["\(key)[]": nestedValue]
                result += convertParamsToArray(dic as [String : AnyObject])
            }
        }
        else if let dicValue = value as? NSDictionary {
            for (nestedKey, nestedValue) in dicValue {
                let dic = ["\(key)[\(nestedKey)]": nestedValue]
                result += convertParamsToArray(dic as [String : AnyObject])
            }
        }
        else {
            result.append(("\(key)", value))
        }
    }
    
    return result
}
