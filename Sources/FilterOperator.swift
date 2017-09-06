//
//  FilterOperator.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 04/09/2017.
//  Copyright © 2017 DIMENSION.
//  See LICENSE file for more details.
//

import Foundation

internal enum FilterOperator : String {
    case equal          = "=="
    case notEqual       = "!="
    case minor          = "<"
    case major          = ">"
    case minorOrEqual   = "<="
    case majorOrEqual   = ">="
    case any            = "any"
    case all            = "all"
    case none           = "none"
    case includes       = "in"
    case doesntInclude  = "!in"
    case has            = "has"
    case doesntHave     = "!has"
    
    func compare(left: Any, right: Any) -> Bool {
        if let left = left as? String, let right = right as? String {
            switch self {
            case .equal:
                return left == right
            case .notEqual:
                return left != right
            default:
                return false
            }
        } else if let left = left as? Int, let right = right as? Int {
            switch self {
            case .equal:
                return left == right
            case .notEqual:
                return left != right
            case .minor:
                return left < right
            case .major:
                return left > right
            case .minorOrEqual:
                return left <= right
            case .majorOrEqual:
                return left >= right
            default:
                return false
            }
        } else if let left = left as? Double, let right = right as? Double {
            switch self {
            case .equal:
                return left == right
            case .notEqual:
                return left != right
            case .minor:
                return left < right
            case .major:
                return left > right
            case .minorOrEqual:
                return left <= right
            case .majorOrEqual:
                return left >= right
            default:
                return false
            }
        } else if let left = left as? Bool, let right = right as? Bool {
            switch self {
            case .equal:
                return left == right
            case .notEqual:
                return left != right
            default:
                return false
            }
        }
        return false
    }
}
