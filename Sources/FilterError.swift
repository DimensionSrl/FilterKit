//
//  FilterError.swift
//  FilterKit
//
//  Created by Matteo Gavagnin on 04/09/2017.
//  Copyright © 2017 DIMENSION.
//  See LICENSE file for more details.
//

import Foundation

#if os(Linux)
public enum FilterError: Int, Error {
    case missingFilters
    case firstElementNotAString
    case unknownOperation
    case propertyNameNotAString
    case noValuesProvidedForProperty
    case missingComparisonValue
    case wrongFilterFormat
    case unrecognizedFlow
}
#else
@objc(FILFilterError)
public enum FilterError: Int, Error {
    case missingFilters
    case firstElementNotAString
    case unknownOperation
    case propertyNameNotAString
    case noValuesProvidedForProperty
    case missingComparisonValue
    case wrongFilterFormat
    case unrecognizedFlow
}

#endif
