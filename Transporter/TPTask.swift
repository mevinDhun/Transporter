//
//  TPTask.swift
//  Example
//
//  Created by Le VanNghia on 3/26/15.
//  Copyright (c) 2015 Le VanNghia. All rights reserved.
//

import Foundation

// TODO
/*
- resume
- suspend
- cancel
*/

open class TPTask : NSObject {
    open var retryCount: UInt = 1
    open var progressHandler: ProgressHandler?
    internal(set) open var isCompleted: Bool = false
    open var isRunning : Bool {
        return !isCompleted
    }
    
    open func progress(_ handler: @escaping ProgressHandler) -> Self {
        progressHandler = handler
        return self
    }
    
    open func resume() {
        
    }
    
    open func suspend() {
        
    }
    
    open func cancel() {
        
    }
}
