//
//  FilterBridge.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 05/09/2017.
//  Copyright © 2017 DIMENSION.
//  See LICENSE file for more details.
//

import Foundation

#if !os(Linux)
@objc(FILFilter)
public class FilterBridge : NSObject {
    
    let filter : Filter!
    
    @objc public var logger : FilterLogLevel = .debug {
        didSet {
            filter?.logger = logger
        }
    }
    
    @objc public init(properties: [String: Any]) {
        filter = Filter(properties: properties)
    }
    
    @objc public func compile(filters: [Any]?) throws -> FilterResult {
        do {
            let result = try filter.compile(filters)
            return FilterResult(result)
        } catch let error {
            throw error
        }
    }
}
#endif
