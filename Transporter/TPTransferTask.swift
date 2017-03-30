//
//  TPTransferTask.swift
//  Example
//
//  Created by Le VanNghia on 3/27/15.
//  Copyright (c) 2015 Le VanNghia. All rights reserved.
//

import Foundation

// TODO
/*
- header configuration
- parameter 
- resume
- suspend
- cancel
*/

open class TPTransferTask : TPTask {
    open var method: TPMethod = .GET
    open var HTTPShouldUsePipelining = false
    open var HTTPShouldHandleCookies = true
    open var allowsCellularAccess = true
    open var params: [String: AnyObject]?
    open var headers: [String: String]?
    open var completionHandler: TransferCompletionHandler?
    
    var url: String
    var request: NSMutableURLRequest?
    var totalBytes: Int64 = 0
    var session: URLSession?
    var responseData: Data?
    var jsonData: String? {
        if let reponseData = responseData {
           // return try! JSONSerialization.jsonObject(with: reponseData, options: .allowFragments) as AnyObject?
            return String.init(data: reponseData, encoding: .utf8)
        }
        return nil
    }
    var error: NSError?
    var failed: Bool {
        return error != nil
    }
    
    public init(url: String, params: [String: AnyObject]? = nil) {
        self.url = url
        self.params = params
        super.init()
    }
   
    func setup() {
        let requestUrl = URL(string: url)!
        let request = NSMutableURLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        request.httpShouldUsePipelining = HTTPShouldUsePipelining
        request.httpShouldHandleCookies = HTTPShouldHandleCookies
        request.allowsCellularAccess = allowsCellularAccess
        
        // append header
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        // append http body
        if let params = params {
            if method == .GET {
                let query = queryStringFromParams(params)
                let newUrl = url + "?\(query)"
                request.url = URL(string: newUrl)
            }
        }
        
       
        //request.httpBody = "url_preset"
        self.request = request
    }
    
    open func completed(_ handler: @escaping(TransferCompletionHandler)) -> Self {
        completionHandler = handler
        return self
    }
}
