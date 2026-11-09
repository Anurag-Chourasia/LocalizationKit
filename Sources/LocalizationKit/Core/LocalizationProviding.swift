import Foundation

public protocol LocalizationProviding: Sendable {
    func string(_ key: String) -> String
    func string(_ key: String, arguments: [CVarArg]) -> String
    func pluralizedString(_ key: String, count: Int) -> String
    var locale: Locale { get }
    var isRightToLeft: Bool { get }
}

public extension LocalizationProviding {
    var locale: Locale { .current }
    var isRightToLeft: Bool { false }
}
