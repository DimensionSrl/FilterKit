//
//  FilterResult.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 05/09/2017.
//  Copyright © 2017 DIMENSION. All rights reserved.
//

import Foundation

#if !os(Linux)
@objc(FILFilterResult)
public class FilterResult : NSObject {
    @objc public let valid : Bool
    
    @objc public init(_ valid: Bool) {
        self.valid = valid
    }
}
#endif
