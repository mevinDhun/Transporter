//
//  TPExtensions.swift
//  Example
//
//  Created by Le VanNghia on 3/26/15.
//  Copyright (c) 2015 Le VanNghia. All rights reserved.
//

import UIKit

extension UIDevice {
    fileprivate class var osVersion: String {
        return UIDevice.current.systemVersion
    }
    
    class func systemVersionEqualTo(_ version: String) -> Bool {
        return osVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
    }
    
    class func systemVersionGreaterThan(_ version: String) -> Bool {
        return osVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
    }
    
    class func systemVersionGreaterThanOrEqualTo(_ version: String) -> Bool {
        return osVersion.compare(version, options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
    }
    
    class func systemVersionLessThan(_ version: String) -> Bool {
        return osVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
    }
    
    class func systemVersionLessThanOrEqualTo(_ version: String) -> Bool {
        return osVersion.compare(version, options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
    }
}
