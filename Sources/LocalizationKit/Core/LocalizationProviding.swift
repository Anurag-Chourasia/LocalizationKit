import Foundation

public protocol LocalizationProviding: Sendable {
    func string(_ key: String) -> String
    func string(_ key: String, arguments: [CVarArg]) -> String
    func pluralizedString(_ key: String, count: Int) -> String
    var isRightToLeft: Bool { get }
}

public extension LocalizationProviding {
    var isRightToLeft: Bool { false }
}
