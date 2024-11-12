//
//  LocalizationManager.swift
//  LocalizationFramework
//
//  Created by Данил Габдуллин on 05.10.2023.
//
import Foundation

public protocol LocalizationProtocol {
    func localize(target: String) -> String
    func localize(target: String, tableName: String) -> String
    func localizePlural(target: String, arg: Int) -> String
    func localizePlural(target: String, arg: Int, tableName: String) -> String
}

private class BundleFinder {}

public let Localization = LocalizationManager(bundle: Bundle(for: BundleFinder.self))

public struct LocalizationManager : Sendable {

    let bundle: Foundation.Bundle
    public let frequentlyUsedStrings = FrequentlyUsedStrings.self
    public let numbersIToStrings = NumbersToStrings.self

    public func localize(_ target: String) -> String {

        NSLocalizedString(
            target,
            comment: "\(target) could not be found"
        )

    }

    public func localize(_ target: String, tableName: String) -> String {

        return NSLocalizedString(
            target,
            tableName: tableName,
            comment: "\(target) could not be found"
        )

    }

    public func localizePlural(_ target: String, arg: Int) -> String {
        let formatString = NSLocalizedString(
            target,
            comment: "\(target) could not be found"
        )
        return String.localizedStringWithFormat(formatString, arg)

    }

    public func localizePlural(_ target: String, arg: Int, tableName: String) -> String {

        let formatString = NSLocalizedString(
            target,
            tableName: tableName,
            comment: "\(target) could not be found"
        )
        return String.localizedStringWithFormat(formatString, arg)

    }

}
