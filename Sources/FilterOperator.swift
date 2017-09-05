//
//  FilterOperator.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 04/09/2017.
//  Copyright © 2017 DIMENSION. All rights reserved.
//

import Foundation

public enum FilterOperator : Int, RawRepresentable {
    case equal          // = "=="
    case notEqual       // = "!="
    case minor          // = "<"
    case major          // = ">"
    case minorOrEqual   // = "<="
    case majorOrEqual   // = ">="
    case any            // = "any"
    case all            // = "all"
    case none           // = "none"
    case includes       // = "in"
    case doesntInclude  // = "!in"
    case has            // = "has"
    case doesntHave     // = "!has"
    case unknown        // everything else
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .equal:
            return "=="
        case .notEqual:
            return "!="
        case .minor:
            return "<"
        case .major:
            return ">"
        case .minorOrEqual:
            return "<="
        case .majorOrEqual:
            return ">="
        case .any:
            return "any"
        case .all:
            return "all"
        case .none:
            return "none"
        case .includes:
            return "in"
        case .doesntInclude:
            return "!in"
        case .has:
            return "has"
        case .doesntHave:
            return "!has"
        case .unknown:
            return "???"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "==":
            self = .equal
        case "!=":
            self = .notEqual
        case "<":
            self = .minor
        case ">":
            self = .major
        case "<=":
            self = .minorOrEqual
        case ">=":
            self = .majorOrEqual
        case "any":
            self = .any
        case "all":
            self = .all
        case "none":
            self = .none
        case "in":
            self = .includes
        case "!in":
            self = .doesntInclude
        case "has":
            self = .has
        case "!has":
            self = .doesntHave
        default:
            self = .unknown
        }
    }
    
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
