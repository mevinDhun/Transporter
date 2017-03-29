//
//  DownloadTask.swift
//  Example
//
//  Created by Le VanNghia on 3/26/15.
//  Copyright (c) 2015 Le VanNghia. All rights reserved.
//

import Foundation

open class DownloadTask : TPTransferTask {
    var task: URLSessionDownloadTask?
    var destination: URL
    var movingError: NSError?
    
    public init(url: String, destination: URL, params: [String: AnyObject]? = nil) {
        self.destination = destination
        super.init(url: url, params: params)
        method = .GET
    }
   
    override func setup() {
        super.setup()
        if let request = request {
            
            task = session?.downloadTask(with: request  as URLRequest)
        }
    }
    
    open override func resume() {
        NSLog("[DownloadTask] did resume")
        task?.resume()
    }
}
