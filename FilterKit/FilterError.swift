//
//  FilterError.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 04/09/2017.
//  Copyright © 2017 DIMENSION. All rights reserved.
//

import Foundation

@objc(FILFilterError)
public enum FilterError: Int, Error {
    case missingFilters
    case firstElementNotAString
    case unknownOperation
    case propertyNameNotAString
    // Those are simpler to mantain Objective-C compatibility
    // case noValuesProvided(forProperty: String)
    // case missingComparisonValue(forProperty: String)
    // case wrongFormat(ofFilter: Any)
    // case unrecognizedFlow(forOperation: FilterOperation)
    case noValuesProvidedForProperty
    case missingComparisonValue
    case wrongFilterFormat
    case unrecognizedFlow
}
