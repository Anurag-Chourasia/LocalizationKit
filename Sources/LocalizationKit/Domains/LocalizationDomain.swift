import Foundation

public protocol LocalizationDomain: Sendable {
    associatedtype Strings: Sendable
    static var domainIdentifier: String { get }
    static func makeStrings(provider: LocalizationProviding) -> Strings
}

public enum ShowBookDomain: LocalizationDomain {
    public typealias Strings = ShowBookStrings
    public static let domainIdentifier = "showbook"

    public static func makeStrings(provider: LocalizationProviding) -> ShowBookStrings {
        ShowBookStrings(provider: provider)
    }
}

public enum MyTVDomain: LocalizationDomain {
    public typealias Strings = MyTVStrings
    public static let domainIdentifier = "mytv"

    public static func makeStrings(provider: LocalizationProviding) -> MyTVStrings {
        MyTVStrings(provider: provider)
    }
}

public enum MotivationDomain: LocalizationDomain {
    public typealias Strings = MotivationStrings
    public static let domainIdentifier = "motivation"

    public static func makeStrings(provider: LocalizationProviding) -> MotivationStrings {
        MotivationStrings(provider: provider)
    }
}
