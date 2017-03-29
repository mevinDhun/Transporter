//
//  UploadTask.swift
//  Example
//
//  Created by Le VanNghia on 3/26/15.
//  Copyright (c) 2015 Le VanNghia. All rights reserved.
//

import Foundation

public enum UploadDataType {
    case data
    case file
    case stream
}

open class UploadTask : TPTransferTask {
    var task: URLSessionUploadTask?
    var uploadDataType: UploadDataType = .file
    var file: URL?
    var data: Data?
    var stream: InputStream?
    
    public override init(url: String, params: [String: AnyObject]? = nil) {
        super.init(url: url, params: params)
        method = .POST
    }
    
    public convenience init(url: String, data: Data) {
        self.init(url: url)
        uploadDataType = .data
        self.data = data
        totalBytes = Int64(data.count)
    }
    
    public convenience init(url: String, file: URL) {
        self.init(url: url)
        uploadDataType = .file
        self.file = file
        
        var error: NSError?
        do {
            let attr: NSDictionary = try FileManager.default.attributesOfItem(atPath: file.path) as NSDictionary
            if error == nil {
                totalBytes = Int64(attr.fileSize())
            }
        } catch let error1 as NSError {
            error = error1
        }
    }
    
    public convenience init(url: String, stream: InputStream) {
        self.init(url: url)
        uploadDataType = .stream
        self.stream = stream
    }
    
    override func setup() {
        super.setup()
        if let request = request {
            switch uploadDataType {
            case .file:
                if let file = self.file {
                    task = session?.uploadTask(with: request as URLRequest, fromFile: file)
                }
            case .data:
                task = session?.uploadTask(with: request as URLRequest, from: data!)
            case .stream:
                task = session?.uploadTask(withStreamedRequest: request as URLRequest)
                break
            }
        }
    }
    
    open override func resume() {
        NSLog("[UploadTask] did resume")
        task?.resume()
    }
}
