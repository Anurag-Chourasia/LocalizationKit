import SwiftUI
import Foundation

// MARK: - Scoped Localized Context with KeyPath Subscripts

@dynamicMemberLookup
public struct LocalizedContext<Domain: LocalizationDomain>: Sendable {
    public let provider: LocalizationProviding
    public let domain: Domain.Strings

    public init(provider: LocalizationProviding) {
        self.provider = provider
        if Domain.self == MotivationDomain.self {
            self.domain = MotivationStrings(provider: provider) as! Domain.Strings
        } else if Domain.self == MyTVDomain.self {
            self.domain = MyTVStrings(provider: provider) as! Domain.Strings
        } else if Domain.self == ShowBookDomain.self {
            self.domain = ShowBookStrings(provider: provider) as! Domain.Strings
        } else {
            fatalError("Unsupported LocalizationDomain: \(Domain.self)")
        }
    }

    public var common: CommonStrings {
        CommonStrings(provider: provider)
    }

    public func string(_ key: String) -> String {
        provider.string(key)
    }

    // Direct KeyPath Subscripts: l10n[\.key]
    public subscript(keyPath: KeyPath<Domain.Strings, String>) -> String {
        domain[keyPath: keyPath]
    }

    public subscript(keyPath: KeyPath<CommonStrings, String>) -> String {
        common[keyPath: keyPath]
    }

    // Dynamic Member Lookup: l10n.key
    public subscript(dynamicMember keyPath: KeyPath<Domain.Strings, String>) -> String {
        domain[keyPath: keyPath]
    }
}

// MARK: - Common Shared Strings

public struct CommonStrings: Sendable {
    private let provider: LocalizationProviding

    public init(provider: LocalizationProviding) {
        self.provider = provider
    }

    public var ok: String { provider.string("common.ok") }
    public var cancel: String { provider.string("common.cancel") }
    public var yes: String { provider.string("common.yes") }
    public var no: String { provider.string("common.no") }
    public var clear: String { provider.string("common.clear") }
    public var share: String { provider.string("common.share") }
    public var close: String { provider.string("common.close") }
    public var done: String { provider.string("account.done") }
    public var retry: String { provider.string("errors.recoverable_retry") }
    public var dismiss: String { provider.string("errors.recoverable_dismiss") }
    public var error: String { provider.string("common.error") }
    public var errorGeneric: String { provider.string("errors.generic") }
}

// MARK: - SwiftUI KeyPath Text Initializers

extension Text {
    /// Initialize with a direct domain keypath: `Text(\.previewShareTitle, in: l10n)`
    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<Domain.Strings, String>, in l10n: LocalizedContext<Domain>) {
        self.init(l10n[keyPath])
    }

    /// Initialize with a direct common keypath: `Text(\.share, in: l10n)`
    public init<Domain: LocalizationDomain>(_ keyPath: KeyPath<CommonStrings, String>, in l10n: LocalizedContext<Domain>) {
        self.init(l10n[keyPath])
    }
}

// MARK: - Environment Keys for Scoped Domains

private struct MotivationL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<MotivationDomain> = LocalizedContext(provider: LocalizationController())
}

private struct MyTVL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<MyTVDomain> = LocalizedContext(provider: LocalizationController())
}

private struct ShowBookL10nKey: EnvironmentKey {
    static let defaultValue: LocalizedContext<ShowBookDomain> = LocalizedContext(provider: LocalizationController())
}

extension EnvironmentValues {
    public var motivationL10n: LocalizedContext<MotivationDomain> {
        get { self[MotivationL10nKey.self] }
        set { self[MotivationL10nKey.self] = newValue }
    }

    public var myTVL10n: LocalizedContext<MyTVDomain> {
        get { self[MyTVL10nKey.self] }
        set { self[MyTVL10nKey.self] = newValue }
    }

    public var showBookL10n: LocalizedContext<ShowBookDomain> {
        get { self[ShowBookL10nKey.self] }
        set { self[ShowBookL10nKey.self] = newValue }
    }
}

// MARK: - View Extension to Inject Domain L10n

extension View {
    public func localizedContext<Domain: LocalizationDomain>(
        _ context: LocalizedContext<Domain>
    ) -> some View {
        Group {
            if let motivationContext = context as? LocalizedContext<MotivationDomain> {
                self.environment(\.motivationL10n, motivationContext)
            } else if let myTVContext = context as? LocalizedContext<MyTVDomain> {
                self.environment(\.myTVL10n, myTVContext)
            } else if let showBookContext = context as? LocalizedContext<ShowBookDomain> {
                self.environment(\.showBookL10n, showBookContext)
            } else {
                self
            }
        }
    }
}
