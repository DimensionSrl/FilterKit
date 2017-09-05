//
//  Filter.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 04/09/2017.
//  Copyright © 2017 DIMENSION. All rights reserved.
//

import Foundation

public class Filter {
    
    fileprivate var properties : [String: Any]
    
    public var logger : FilterLogLevel = .debug
    
    public init(properties: [String: Any]) {
        self.properties = properties
    }
    
    public func compile(_ filters: [Any]?) throws -> Bool {
        guard let filters = filters else {
            return true
        }
        guard let opString = filters.first as? String else {
            logger.log(.error, message: "First element is not a string")
            throw FilterError.firstElementNotAString
        }
        guard let op = FilterOperator(rawValue: opString) else {
            logger.log(.error, message: "Unknown operation \(opString)")
            throw FilterError.unknownOperation
        }
        guard op != .unknown else {
            logger.log(.error, message: "Unknown operation \(opString)")
            throw FilterError.unknownOperation
        }
        
        switch op {
        case .equal, .notEqual, .minor, .major, .minorOrEqual, .majorOrEqual:
            do {
                if filters.count <= 2 {
                    logger.log(.error, message: "Missing Comparison Value for: \(filters[1])")
                    throw FilterError.missingComparisonValue
                }
                return try compileComparisonOp(property: filters[1], value: filters[2], operation: op)
            } catch let error {
                throw error
            }
        case .all, .any, .none:
            guard filters.count > 1 else {
                logger.log(.error, message: "Missing Filters: \(op)")
                throw FilterError.missingFilters
            }
            var followingFilters = filters
            followingFilters.removeFirst()
            do {
                return try compileLogicalOp(filters: followingFilters, operation: op)
            } catch let error {
                throw error
            }
        case .has, .doesntHave:
            do {
                return try compileHasOp(property: filters[1], operation: op)
            } catch let error {
                throw error
            }
        case .includes, .doesntInclude:
            guard filters.count > 2 else {
                logger.log(.error, message: "No values provided for property \(filters[1])")
                throw FilterError.noValuesProvidedForProperty
            }
            var followingFilters = filters
            followingFilters.removeFirst()
            followingFilters.removeFirst()
            do {
                return try compileInOp(property: filters[1], values: followingFilters, operation: op)
            } catch let error {
                throw error
            }
        case .unknown:
            logger.log(.error, message: "Unknown operation \(opString)")
            throw FilterError.unknownOperation
        }
    }
    
    fileprivate func compilePropertyReference(_ property: String) -> Any? {
        return properties[property]
    }
    
    fileprivate func compileComparisonOp(property: Any?, value: Any?, operation: FilterOperator) throws -> Bool {
        guard let propertyString = property as? String else {
            logger.log(.error, message: "Property name is not a string")
            throw FilterError.propertyNameNotAString
        }
        guard let left = compilePropertyReference(propertyString) else {
            logger.log(.info, message:"Cannot find property: \(propertyString)")
            return false
        }
        guard let right = value else {
            logger.log(.error, message: "Missing Comparison Value for: \(propertyString)")
            throw FilterError.missingComparisonValue
        }
        
        return operation.compare(left: left, right: right)
    }
    
    fileprivate func compileLogicalOp(filters: [Any]?, operation: FilterOperator) throws -> Bool {
        guard let filters = filters else {
            logger.log(.error, message: "Missing Filters: \(operation)")
            throw FilterError.missingFilters
        }
        
        var defaultResult = false
        switch operation {
        case .all:
            defaultResult = true
            break
        case .any:
            defaultResult = false
            break
        case .none:
            defaultResult = true
            break
        default:
            logger.log(.error, message: "Unrecognized Flow for Operation: \(operation)")
            throw FilterError.unrecognizedFlow
        }
        
        for nestedFilter in filters {
            guard let _nestedFilter = nestedFilter as? [Any] else {
                logger.log(.error, message: "Wrong format of filter: \(nestedFilter)")
                throw FilterError.wrongFilterFormat
            }
            do {
                let result = try compile(_nestedFilter)
                switch operation {
                case .all:
                    if result == false {
                        logger.log(.info, message: "All: \(_nestedFilter) with \(properties)")
                        return false
                    }
                    break
                case .any:
                    if result == true {
                        logger.log(.info, message: "Any: \(_nestedFilter) with \(properties)")
                        return true
                    }
                case .none:
                    if result == true {
                        logger.log(.info, message: "None: \(_nestedFilter) with \(properties)")
                        return false
                    }
                default:
                    logger.log(.error, message: "Unrecognized Flow for Operation: \(operation)")
                    throw FilterError.unrecognizedFlow
                }
            } catch let error {
                throw error
            }
        }
        logger.log(.verbose, message: "Returning \(defaultResult) from logical operation")
        return defaultResult
    }
    
    fileprivate func compileHasOp(property: Any?, operation: FilterOperator) throws -> Bool {
        guard let propertyString = property as? String else {
            logger.log(.error, message: "Property name not a string")
            throw FilterError.propertyNameNotAString
        }
        if let _ = compilePropertyReference(propertyString) {
            switch operation {
            case .has:
                return true
            case .doesntHave:
                return false
            default:
                logger.log(.error, message: "Unrecognized Flow for Operation: \(operation)")
                throw FilterError.unrecognizedFlow
            }
        }
        switch operation {
        case .has:
            return false
        case .doesntHave:
            return true
        default:
            logger.log(.error, message: "Unrecognized Flow for Operation: \(operation)")
            throw FilterError.unrecognizedFlow
        }
    }
    
    fileprivate func compileInOp(property: Any?, values: [Any]?, operation: FilterOperator) throws -> Bool {
        guard let propertyString = property as? String else {
            logger.log(.error, message: "Property name not a string")
            throw FilterError.propertyNameNotAString
        }
        guard let values = values else {
            logger.log(.error, message: "No values provided for property \(propertyString)")
            throw FilterError.noValuesProvidedForProperty
        }
        guard let left = compilePropertyReference(propertyString) else {
            logger.log(.info, message: "Cannot find property: \(propertyString)")
            return false
        }
        
        let satisfied = values.contains {
            if let left = left as? String, let right = $0 as? String {
                return left == right
            } else if let left = left as? Int, let right = $0 as? Int {
                return left == right
            } else if let left = left as? Double, let right = $0 as? Double {
                return left == right
            } else if let left = left as? Bool, let right = $0 as? Bool {
                return left == right
            }
            return false
        }
        switch operation {
        case .includes:
            return satisfied
        case .doesntInclude:
            return !satisfied
        default:
            logger.log(.error, message: "Unrecognized Flow for Operation: \(operation)")
            throw FilterError.unrecognizedFlow
        }
    }
}
