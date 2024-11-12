//
//  LocalizationDateFormatter.swift
//  LocalizationFramework
//
//  Created by Данил Габдуллин on 22.11.2023.
//

import Foundation

public protocol LocalizationDateFormatterProtocol {
    func getStringFromTimeInterval(timeInterval: TimeInterval, format: DateFormats) -> String
    func getTimeIntervalFromString(string: String, format: DateFormats) -> TimeInterval
    func getStringFromDate(date: Date, format: DateFormats) -> String
    func getDateFromString(string: String, format: DateFormats) -> Date
}

//MARK: - global Formatter
public let FormatterForDate = LocalizationDateFormatter(bundle: Bundle(for: BundleFinder.self))

private class BundleFinder {}

//MARK: - LocalizationNumberFormatter class
public struct LocalizationDateFormatter: LocalizationDateFormatterProtocol, Sendable {
    
    let bundle: Foundation.Bundle
    
    public func getStringFromTimeInterval(timeInterval: TimeInterval, format: DateFormats) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return format.formatter.string(from: date)
    }
    
    public func getTimeIntervalFromString(string: String, format: DateFormats) -> TimeInterval {
        return format.formatter.date(from: string)?.timeIntervalSince1970 ?? 0
    }
    
    public func getStringFromDate(date: Date, format: DateFormats) -> String {
        return format.formatter.string(from: date)
    }
    
    public func getDateFromString(string: String, format: DateFormats) -> Date {
        let date = format.formatter.date(from: string)
        return date ?? Date(timeIntervalSince1970: 0)
    }
    
}

// MARK: - Formats
public enum DateFormats {
    case standart
}

public extension DateFormats {
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        switch self {
        case .standart:
            formatter.dateFormat = "dd.MM.yyyy"
        }
        return formatter
    }
}

// MARK: - Errors
public enum DateValidationError: Error {
    case invalidTimeInterval
    case invalidString
}

public extension DateValidationError {
    var description: String {
        switch self {
        case .invalidTimeInterval:
            return "TimeInterval is invalid"
        case .invalidString:
            return "String is invalid"
        }
    }
}
