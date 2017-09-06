//
//  FilterLogLevel.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 04/09/2017.
//  Copyright © 2017 DIMENSION.
//  See LICENSE file for more details.
//

import Foundation

#if os(Linux)
    public enum FilterLogLevel: Int {
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        
        func log(_ level: FilterLogLevel, message: String) {
            if level.rawValue <= self.rawValue {
                print(message)
            }
        }
    }
#else
    @objc(FILFilterLogLevel)
    public enum FilterLogLevel: Int {
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        
        func log(_ level: FilterLogLevel, message: String) {
            if level.rawValue <= self.rawValue {
                print(message)
            }
        }
    }
#endif
