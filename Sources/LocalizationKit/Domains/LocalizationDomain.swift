import Foundation

public protocol LocalizationDomain: Sendable {
    associatedtype Strings: Sendable
    static var domainIdentifier: String { get }
}

public enum ShowBookDomain: LocalizationDomain {
    public typealias Strings = ShowBookStrings
    public static let domainIdentifier = "showbook"
}

public enum MyTVDomain: LocalizationDomain {
    public typealias Strings = MyTVStrings
    public static let domainIdentifier = "mytv"
}

public enum MotivationDomain: LocalizationDomain {
    public typealias Strings = MotivationStrings
    public static let domainIdentifier = "motivation"
}
