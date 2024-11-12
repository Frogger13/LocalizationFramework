//
//  LocalizationNumberFormatter.swift
//  LocalizationFramework
//
//  Created by Данил Габдуллин on 06.10.2023.
//

import Foundation
//MARK: - LocalizationFormatter Protocol

public protocol LocalizationNumberFormatterProtocol {
    func getFormattedStringFromNumber(number: Int, format: NumberFormat) -> String
    func getNumberFromFormattedString(string: String) -> Int?
    func getStringFromFormattedString(string: String) -> String
}

//MARK: - global Formatter
public let FormatterForNumbers = LocalizationNumberFormatter(bundle: Bundle(for: BundleFinder.self))

private class BundleFinder {}

//MARK: - LocalizationNumberFormatter class
public struct LocalizationNumberFormatter : Sendable {
    
    let bundle: Foundation.Bundle
}

// MARK: - Extesion LocalizationNumberFormatterProtocol
extension LocalizationNumberFormatter: LocalizationNumberFormatterProtocol {
    
    public func getFormattedStringFromNumber(number: Int, format: NumberFormat) -> String {
        return format.formatter.string(from: number as NSNumber) ?? FrequentlyUsedStrings.emptyString
    }
    
    
    public func getNumberFromFormattedString(string: String) -> Int? {
        let amount = string.replacingOccurrences(of: " ", with: "")
        guard let intAmount = Int(amount) else { return nil }
        return intAmount
    }
    
    public func getStringFromFormattedString(string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "")
    }
    
}

//MARK: - Enums
public enum NumberFormat {
    case standartFormatter
}

public enum NumberValidationError: Error {
    case invalidNumber
    case invalidString
}

//MARK: - Extencions
public extension NumberFormat {
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        switch self {
        case .standartFormatter:
            formatter.groupingSize = 3
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            formatter.usesGroupingSeparator = true
        }
        return formatter
    }
    
}

public extension NumberValidationError {
    var description: String {
        switch self {
        case .invalidNumber:
            return "Number is invalid"
        case .invalidString:
            return "String is invalid"
        }
    }
}

